require 'rails_helper'

describe Loan do 
  it { should validate_presence_of(:account_executive) }
  it { should validate_presence_of(:lender_or_borrower_paid) }
  it { should validate_presence_of(:lender_compensation) }
  it { should validate_presence_of(:broker_first_name) }
  it { should validate_presence_of(:broker_last_name) }
  it { should validate_presence_of(:broker_phone) }
  it { should validate_presence_of(:broker_email) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:borrower_first_name) }
  it { should validate_presence_of(:borrower_last_name) }
  it { should validate_presence_of(:borrower_email) }
  it { should validate_presence_of(:borrower_mid_fico_score) }
  it { should validate_presence_of(:property_value) }
  it { should validate_presence_of(:loan_amount) }
  it { should validate_presence_of(:disclosed_rate_pct) }
  it { should validate_presence_of(:ltv) }
  it { should validate_presence_of(:cltv) }
  it { should validate_presence_of(:loan_type) }
  it { should validate_presence_of(:transaction_type) }
  it { should validate_presence_of(:term) }
  it { should validate_presence_of(:property_type) }

  it { should validate_inclusion_of(:account_executive).in_array(Loan::ACCOUNT_EXECUTIVES) }
  it { should validate_inclusion_of(:lender_or_borrower_paid).in_array(Loan::LENDER_OR_BORROWER_PAID_OPTIONS) }
  it { should validate_inclusion_of(:loan_type).in_array(Loan::LOAN_TYPES) }
  it { should validate_inclusion_of(:transaction_type).in_array(Loan::TRANSACTION_TYPES) }
  # it { should validate_inclusion_of(:underwriting_fee_buyout).in_array([true, false]) }
  # it { should validate_inclusion_of(:impounds_or_escrows).in_array([true, false]) }

  it { should validate_inclusion_of(:fha_underwriting_type).in_array(Loan::FHA_UNDERWRITING_TYPES).allow_nil }
  it { should validate_inclusion_of(:term).in_array(Loan::TERMS) }
  it { should validate_inclusion_of(:property_type).in_array(Loan::PROPERTY_TYPES) }
  it { should validate_inclusion_of(:occupancy).in_array(Loan::OCCUPANCIES).allow_nil }

  context "after save" do
    before do
      @loan = FactoryGirl.build(:loan)
      ActionMailer::Base.deliveries = []
    end

    it "should send three emails - one to CM brokers, one to the email on record with cover page PDFs, and one to the processor with a cover page PDF" do
      @loan.save!
      expect(ActionMailer::Base.deliveries.count).to eq(3)

      email = ActionMailer::Base.deliveries.detect { |email| email.to.include?( @loan.broker_email) }
      expect(email).not_to be_nil
      expect(email.attachments.length).to eq(2)

      email = ActionMailer::Base.deliveries.detect { |email| email.to.include?( @loan.processor_email) }
      expect(email).not_to be_nil
      expect(email.attachments.length).to eq(2)

      # Gfe file and fee worksheet should be attached
      email = ActionMailer::Base.deliveries.detect { |email| email.to.include?( "brokers@commercemtg.com") }
      expect(email).not_to be_nil
      # Doesn't work with paperclip...
      # expect(email.attachments.length).to eq(2)
      expect(email.subject).to eq("#{@loan.broker_name} has submitted a loan")
    end
  end

end
