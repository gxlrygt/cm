class LoanType < ActiveRecord::Base
  module LOAN_TYPE
    CONVENTIONAL = "Conventional (Jumbo, ARMs, etc)"
    FHA = "FHA"
    VA = "VA"
  end

  LOAN_TYPES = [LOAN_TYPE::CONVENTIONAL, LOAN_TYPE::FHA, LOAN_TYPE::VA]

  validates :name, presence: true
  validates :name, inclusion: { in: LOAN_TYPES }
  has_and_belongs_to_many :broker_approval_forms, -> { uniq }
end