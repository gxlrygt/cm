FactoryGirl.define do
  factory :state do
  	sequence(:name) { |n| "state_#{n}" }
    sequence(:code) { |n| "#{n}#{n}" }
  end

end
