FactoryGirl.define do
  factory :contact_form do
    name "Batman"
    company "Wayne Corporation"
    sequence(:email) { |n| "batman_#{n}@wayne.co" }
    message "I'm watching you"
  end

end
