class BrokerApprovalForm < ActiveRecord::Base
  COMPANY_TYPES = ["Other", "Corporation", "Limited Liability Company", "Limited Partnership"].freeze
  HOW_DID_YOU_FIND_US = ["Contacted by Account Executive", "Search Engine", "Comergence", "Other"].freeze
  COMPENSATION_PERCENTAGE = ["1.00% - Compensation Percentage",
    "1.25% - Compensation Percentage",
    "1.50% - Compensation Percentage",
    "1.75% - Compensation Percentage",
    "2.00% - Compensation Percentage",
    "2.25% - Compensation Percentage",
    "2.50% - Compensation Percentage",
    "2.75% - Compensation Percentage"]
  MAXIMUM_COMPENSATION = ["$15,000", "$17,500", "$20,000"]
  PDF_FORMS = {
    mortgage_broker_agreement: { footer_name: "Mortgage Broker Agreement", filename: "mortgage_broker_agreement.pdf" },
    loan_fraud: { footer_name: "Loan Fraud", filename: "loan_fraud.pdf" },
    fair_lending_acknowledgement: { footer_name: "Fair Lending Acknowledgement", filename: "fair_lending_acknowledgement.pdf" },
    #broker_approval_checklist: { footer_name: "Broker Approval Checklist", filename: "broker_approval_checklist.pdf" },
    company_resolution_doc_3: { footer_name: "Company Resolution", filename: "company_resolution_doc_3.pdf" },
    company_resolution_doc_4: { footer_name: "Company Resolution", filename: "company_resolution_doc_4.pdf" },
    fha_sponsorship: { footer_name: "FHA Sponsorship", filename: "fha_sponsorship.pdf" },
    quality_control: { footer_name: "Quality Control & Compliance Agreement", filename: "quality_control_and_compliance_agreement.pdf" },
    respa: { footer_name: "RSAPA", filename: "respa.pdf" },
    sales_compensation: { footer_name: "Sales Compensation", filename: "sales_compensation.pdf" },
    va_sponsorship: { footer_name: "VA Sponsorship", filename: "va_sponsorship.pdf" }
  }

  belongs_to :state
  has_and_belongs_to_many :loan_types, -> { uniq }, dependent: :destroy
  has_many :tpo_user_access_requests, inverse_of: :broker_approval_form

  accepts_nested_attributes_for :tpo_user_access_requests, reject_if: proc { |attributes| attributes['role'].blank? && attributes['first_name'].blank? && attributes['last_name'].blank? && attributes['email'].blank? }

  validates :company, :company_type, :company_president, :broker_of_record, :nmls, :address, :city, :state, :zip, :primary_contact, :title, :how_did_you_find_us, :lender_paid_compensation_percentage, :maximum_compensation, :email, presence: true
  validate :at_least_one_loan_type
  validates :lender_paid_compensation_percentage, inclusion: { in: COMPENSATION_PERCENTAGE }
  validates :maximum_compensation, inclusion: { in: MAXIMUM_COMPENSATION }
  validates :company_type, inclusion: { in: COMPANY_TYPES }
  validates :how_did_you_find_us, inclusion: { in: HOW_DID_YOU_FIND_US }

  def pretty_date
    created_at.strftime('%m-%d-%Y')
  end

  def at_least_one_loan_type
    errors.add(:loan_type, "(Conventional, FHA, or VA) must be selected") if loan_types.length == 0
  end

  # Returns the name of the template for the broker approval checklist PDF
  def broker_approval_checklist_template
    loan_types_in_form = loan_types.map(&:name)
    template = nil
    if loan_types_in_form.length == 1 && loan_types_in_form.first == LoanType::LOAN_TYPE::CONVENTIONAL
      template = "broker_approval_checklist_option_1"
    elsif (loan_types_in_form.length == 1 && loan_types_in_form.first == LoanType::LOAN_TYPE::FHA) || (loan_types_in_form.length == 2 && loan_types_in_form.include?(LoanType::LOAN_TYPE::CONVENTIONAL) && loan_types_in_form.include?(LoanType::LOAN_TYPE::FHA))
      template = "broker_approval_checklist_option_2"
    elsif (loan_types_in_form.length == 1 && loan_types_in_form.first == LoanType::LOAN_TYPE::VA) || (loan_types_in_form.length == 2 && loan_types_in_form.include?(LoanType::LOAN_TYPE::CONVENTIONAL) && loan_types_in_form.include?(LoanType::LOAN_TYPE::VA))
      template = "broker_approval_checklist_option_3"
    elsif (loan_types_in_form.length == 3)
      template = "broker_approval_checklist_option_4"
    end

    template
  end

  after_create :notify_brokers, :send_pdf_package

  private

  def send_pdf_package
    BrokerApprovalFormService::PdfMailer.new(self.id).delay.perform
  end

  def notify_brokers
    BrokerFormsMailer.delay.notify_brokers(self)
  end
end
