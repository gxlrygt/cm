class Loan < ActiveRecord::Base
  ACCOUNT_EXECUTIVES = [
    "N/A",
    "Gary Williamson",
    "Chi Do",
    "Nicole Kusano",
    "Dennis Taormina",
    "Cindy Fessler",
    "Jill Glass",
    "John Reiher",
    "Perri Herman",
    "Roxanne Jackson",
    "Stephanie Cox",
    "Michael Bennett",
    "Kim Soash"
  ]
  LENDER_OR_BORROWER_PAID_OPTIONS = [
    "Lender Paid",
    "Borrower Paid"
  ]
  LOAN_TYPES = [
    "FHA",
    "VA",
    "VA IRRL W/ Appraisal",
    "VA IRRL W/O Appraisal",
    "Conventional",
    "DU Refi Plus",
    "LP Open Access"
  ]
  TRANSACTION_TYPES = [
    "Purchase",
    "Rate & Term",
    "Cash-Out",
    "Streamline",
    "IRRL"
  ]
  FHA_UNDERWRITING_TYPES = [
    "Non-Credit Qual",
    "Credit"
  ]
  TERMS = [
    "30yr",
    "20yr",
    "15yr",
    "10yr"
  ]
  PROPERTY_TYPES = [
    "SFR",
    "PUD",
    "Condo",
    "2 Unit",
    "3-4 Unit",
    "Manufactured"
  ]
  OCCUPANCIES = [
    "Primary",
    "2nd Home",
    "Investment"
  ]

  belongs_to :state

  has_attached_file :gfe_file
  has_attached_file :fee_worksheet
  do_not_validate_attachment_file_type :gfe_file
  do_not_validate_attachment_file_type :fee_worksheet

  validates :account_executive, :lender_or_borrower_paid, :lender_compensation, :broker_first_name, :broker_last_name, :broker_phone, :broker_email, :address, :city, :state, :zip, :borrower_first_name, :borrower_last_name, :borrower_email, :borrower_mid_fico_score, :property_value, :loan_amount, :disclosed_rate_pct, :ltv, :cltv, :loan_type, :transaction_type, :term, :property_type, presence: true
  validates :underwriting_fee_buyout, :impounds_or_escrows, inclusion: [true, false]
  
  validates :account_executive, inclusion: { in: ACCOUNT_EXECUTIVES }
  validates :lender_or_borrower_paid, inclusion: { in: LENDER_OR_BORROWER_PAID_OPTIONS }
  validates :loan_type, inclusion: { in: LOAN_TYPES }
  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES }
  validates :fha_underwriting_type, inclusion: { in: FHA_UNDERWRITING_TYPES }, allow_nil: true
  validates :term, inclusion: { in: TERMS }
  validates :property_type, inclusion: { in: PROPERTY_TYPES }
  validates :occupancy, inclusion: { in: OCCUPANCIES }, allow_nil: true

  # Returns the which documents to package based on which loan program was selected
  def document_template
    template = "document_option_4"
    if loan_type == "FHA" && transaction_type != "Streamline"
      template = "document_option_1"
    elsif loan_type == "VA" || loan_type == "VA IRRL W/ Appraisal" || loan_type == "VA IRRL W/O Appraisal"
      template = "document_option_2"
    elsif loan_type == "FHA" && transaction_type == "Streamline"
      template = "document_option_3"
    end

    template
  end

  def pretty_date
    created_at.strftime('%m-%d-%Y')
  end

  def broker_name
    "#{broker_first_name} #{broker_last_name}"
  end

  after_create :notify_brokers, :send_email_to_broker, :send_email_to_processor

  private

  def send_email_to_broker
    LoanService::CoverPageMailer.new(id, broker_email).delay.perform
  end

  def send_email_to_processor
    LoanService::CoverPageMailer.new(id, processor_email).delay.perform if processor_email
  end

  def notify_brokers
    LoanService::BrokerNotifierMailer.new(self.id).delay.perform
  end
end