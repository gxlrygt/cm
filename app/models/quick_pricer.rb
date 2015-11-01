class QuickPricer
  include ActiveModel::Model
  module RateLockTerm
    FifteenDays = "15 Days"
    ThirtyDays = "30 Days"
    FourtyFiveDays = "45 Days"
    SixtyDays = "60 Days"
  end
  RATE_LOCK_TERMS = [RateLockTerm::FifteenDays, RateLockTerm::ThirtyDays, RateLockTerm::FourtyFiveDays, RateLockTerm::SixtyDays]

  module ArmFixedTerm
    ThreeYears = "3 Yr"
    FiveYears = "5 Yr"
    SevenYears = "7 Yr"
    TenYears = "10 Yr"
  end
  ARM_FIXED_TERMS = [ArmFixedTerm::ThreeYears, ArmFixedTerm::FiveYears, ArmFixedTerm::SevenYears, ArmFixedTerm::TenYears]
 
  module LoanPurpose
    Purchase = "Purchase"
    RefiCashOut = "Refi – Cash Out"
    RefiRateTerm = "Refi – Rate/Term"
    FhaStreamline = "FHA Streamline"
    VaRateReduction = "VA Rate Reduction"
  end
  LOAN_PURPOSES = [LoanPurpose::Purchase, LoanPurpose::RefiCashOut, LoanPurpose::RefiRateTerm, LoanPurpose::FhaStreamline, LoanPurpose::VaRateReduction]

  module LoanTerm
    ThirtyYear = "30 Yr"
    TwentyFiveYear = "25 Yr"
    TwentyYear = "20 Yr"
    FifteenYear = "15 Yr"
    TenYear = "10 Yr"
  end
  LOAN_TERMS = [LoanTerm::ThirtyYear, LoanTerm::TwentyFiveYear, LoanTerm::TwentyYear, LoanTerm::FifteenYear, LoanTerm::TenYear]

  module PropertyUse
    Primary = "Primary Residence"
    Second = "Second Home"
    Investment = "Investment Property"
  end
  PROPERTY_USES = [PropertyUse::Primary, PropertyUse::Second, PropertyUse::Investment]

  module PropertyType
    SingleFamily = "Single Family"
    Condo = "Condo"
    PUD = "PUD"
    Manufactured = "Manufactured"
    Coop = "Coop"
    NonWarrantableCondo = "Non Warrantable Condo"
  end
  PROPERTY_TYPES = [PropertyType::SingleFamily, PropertyType::Condo, PropertyType::PUD, PropertyType::Manufactured, PropertyType::Coop, PropertyType::NonWarrantableCondo]

  module Unit
    OneUnit = "1 Unit"
    TwoUnits = "2 Units"
    ThreeUnits = "3 Units"
    FourUnits = "4 Units"
  end
  UNITS = [Unit::OneUnit, Unit::TwoUnits, Unit::ThreeUnits, Unit::FourUnits]

  module Story
    OneStory = "1"
    TwoStory = "2"
    ThreeStory = "3"
    FourStory = "4"
  end
  STORIES = [Story::OneStory, Story::TwoStory, Story::ThreeStory, Story::FourStory]

  module AutoUwSystem
    NotSpecific = "Not Specific"
    DU = "DU"
    LP = "LP"
    InvestorAus = "Investor AUS"
    ManualTraditional = "Manual/Traditional"
  end
  AUTO_UW_SYSTEM_OPTIONS = [AutoUwSystem::NotSpecific, AutoUwSystem::DU, AutoUwSystem::LP, AutoUwSystem::InvestorAus, AutoUwSystem::ManualTraditional]

  module ProductType
    Conforming = "Conforming"
    FHA = "FHA"
    VA = "VA"
    NonConfirming = "Non-Conforming"
  end
  PRODUCT_TYPES = [ProductType::Conforming, ProductType::FHA, ProductType::VA, ProductType::NonConfirming]

  module AmortizationType
    Fixed = "Fixed"
    ARM = "ARM"
  end
  AMORTIZATION_TYPES = [AmortizationType::Fixed, AmortizationType::ARM]

  attr_accessor :state_id, :county_name, :county_fips, :loan_amount, :loan_purpose, :county, :cltv, :appraisal_amount, :borrower_paid_mi, :property_type, :mortgage_insurance, :cash_out_amount, :units, :stories, :property_use, :rate_lock_term, :arm_fixed_term, :waived_escrows, :auto_uw_system, :credit_score, :loan_term, :product_type, :debt_to_income_pct, :amortization_type
end