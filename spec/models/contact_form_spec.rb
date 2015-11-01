require 'rails_helper'

describe ContactForm do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  
  context "after save" do
    before do
      @contact_form = FactoryGirl.build(:contact_form)
      ActionMailer::Base.deliveries = []
    end

    it "should send one email to notify the brokers" do
      @contact_form.save!
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
