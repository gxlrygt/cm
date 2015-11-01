require 'rails_helper'

describe TpoUserAccessRequest do
  it { should validate_inclusion_of(:role).in_array(User::ROLES) }

  it "should require user fields if any of the user fields are filled out" do
    tpo_user_access_request = FactoryGirl.build(:tpo_user_access_request)
    tpo_user_access_request.first_name = "Pie"
    expect(tpo_user_access_request.valid?).to eq(false)
    expect(tpo_user_access_request.errors).to include(:last_name)
    expect(tpo_user_access_request.errors).to include(:email)
    expect(tpo_user_access_request.errors).to include(:role)

    tpo_user_access_request = FactoryGirl.build(:tpo_user_access_request)
    tpo_user_access_request.last_name = "Pie"
    expect(tpo_user_access_request.valid?).to eq(false)
    expect(tpo_user_access_request.errors).to include(:first_name)
    expect(tpo_user_access_request.errors).to include(:email)
    expect(tpo_user_access_request.errors).to include(:role)

    tpo_user_access_request = FactoryGirl.build(:tpo_user_access_request)
    tpo_user_access_request.email = "user@email.com"
    expect(tpo_user_access_request.valid?).to eq(false)
    expect(tpo_user_access_request.errors).to include(:last_name)
    expect(tpo_user_access_request.errors).to include(:first_name)
    expect(tpo_user_access_request.errors).to include(:role)

    tpo_user_access_request = FactoryGirl.build(:tpo_user_access_request)
    tpo_user_access_request.role = User::ROLE::LoanOfficer
    expect(tpo_user_access_request.valid?).to eq(false)
    expect(tpo_user_access_request.errors).to include(:last_name)
    expect(tpo_user_access_request.errors).to include(:email)
    expect(tpo_user_access_request.errors).to include(:first_name)
  end
end
