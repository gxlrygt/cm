FactoryGirl.define do
  factory :loan do
    account_executive Loan::ACCOUNT_EXECUTIVES.first
    lender_or_borrower_paid Loan::LENDER_OR_BORROWER_PAID_OPTIONS.first
    lender_compensation "123"
    broker_first_name "Clark"
    broker_last_name "Kent"
    broker_phone "123superman"
    sequence(:broker_email) { |n| "super_#{n}@man.com" }
    address "123 Fake Street"
    city "Fake City"
    association :state
    zip "12345"
    processor_first_name "Pro"
    processor_last_name "Cessor"
    sequence(:processor_email) { |n| "bat_#{n}@man.com" }
    borrower_first_name "Peter"
    borrower_last_name "Parker"
    sequence(:borrower_email) { |n| "spider_#{n}@man.com" }
    borrower_mid_fico_score "12"
    property_value "12345"
    loan_amount "1000"
    disclosed_rate_pct 1.23
    ltv "blah"
    cltv "blaah"
    loan_type Loan::LOAN_TYPES.first
    transaction_type Loan::TRANSACTION_TYPES.first
    term Loan::TERMS.first
    property_type Loan::PROPERTY_TYPES.first
    underwriting_fee_buyout false
    impounds_or_escrows true
  end

end
