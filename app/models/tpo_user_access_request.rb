class TpoUserAccessRequest < ActiveRecord::Base
  belongs_to :broker_approval_form, inverse_of: :tpo_user_access_requests

  validates :broker_approval_form, presence: true
  validates :role, inclusion: { in: User::ROLES, allow_nil: true }
  validates :first_name, presence: true, if: "last_name || email || role"
  validates :last_name, presence: true, if: "first_name || email || role"
  validates :email, presence: true, if: "first_name || last_name || role"
  validates :role, presence: true, if: "first_name || last_name || email"
end
