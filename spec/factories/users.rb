FactoryGirl.define do
  factory :user do
  	first_name "Bruce"
  	last_name "Wayne"
    sequence(:email) { |n| "user_#{n}@gotham.gov" }
    password "Password123"
  end

end
