require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it "should create external site passwords" do
  	u = FactoryGirl.create(:user)
  	expect(u.external_site_passwords.count).to eq(ExternalSitePassword::EXTERNAL_SITES.length)
  end
end
