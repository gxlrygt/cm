FactoryGirl.define do
  factory :broker_approval_form do
    company "Bruce Wayne"
    company_type "Corporation"
    company_president "Somebody Awesome"
    broker_of_record "Alfred P"
    nmls "12345"
    address "123 Batcave"
    city "Gotham"
    association :state
    zip "12345"
    primary_contact "Bruce Wayne"
    title "Batman"
    how_did_you_find_us BrokerApprovalForm::HOW_DID_YOU_FIND_US.first
    lender_paid_compensation_percentage BrokerApprovalForm::COMPENSATION_PERCENTAGE.last
    maximum_compensation BrokerApprovalForm::MAXIMUM_COMPENSATION.last
    sequence(:email) { |n| "batman_#{n}@cia.gov" }

    after(:build)  { |form| form.loan_types << FactoryGirl.create(:loan_type) }
  end

end
