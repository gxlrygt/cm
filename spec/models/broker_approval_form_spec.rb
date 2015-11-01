require 'rails_helper'

describe BrokerApprovalForm do
  it { should have_and_belong_to_many(:loan_types) }
  
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:company_type) }
  it { should validate_presence_of(:company_president) }
  it { should validate_presence_of(:broker_of_record) }
  it { should validate_presence_of(:nmls) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:primary_contact) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:how_did_you_find_us) }
  it { should validate_presence_of(:lender_paid_compensation_percentage) }
  it { should validate_presence_of(:maximum_compensation) }
  it { should validate_presence_of(:email) }

  it { should validate_inclusion_of(:lender_paid_compensation_percentage).in_array(BrokerApprovalForm::COMPENSATION_PERCENTAGE) }
  it { should validate_inclusion_of(:maximum_compensation).in_array(BrokerApprovalForm::MAXIMUM_COMPENSATION) }
  it { should validate_inclusion_of(:company_type).in_array(BrokerApprovalForm::COMPANY_TYPES) }
  it { should validate_inclusion_of(:how_did_you_find_us).in_array(BrokerApprovalForm::HOW_DID_YOU_FIND_US) }

  context "loan_types" do
    before do
      LoanType::LOAN_TYPES.each do |lt|
        LoanType.create(name: lt)
      end
    end

    it "should validate there's at least one loan type" do
      b = BrokerApprovalForm.new
      b.valid?
      expect(b.errors).to include(:loan_type)

      b = BrokerApprovalForm.new("loan_type_ids"=>[LoanType.first.id])
      b.valid?
      expect(b.errors).not_to include(:loan_type)
    end
  end

  context "after save" do
    before do
      @broker_approval_form = FactoryGirl.build(:broker_approval_form)
      ActionMailer::Base.deliveries = []
    end

    it "should send two emails - one to CM brokers and one to the user with PDFs" do
      @broker_approval_form.save!
      expect(ActionMailer::Base.deliveries.count).to eq(2)

      email = ActionMailer::Base.deliveries.detect { |email| email.to.include?( @broker_approval_form.email) }
      expect(email).not_to be_nil
      # One image, one pdf
      expect(email.attachments.length).to eq(2)
    end
  end
end
