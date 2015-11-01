class AddUserFieldsToBrokerApprovalForm < ActiveRecord::Migration
  def change
    add_column :broker_approval_forms, :user_first_name, :string
    add_column :broker_approval_forms, :user_last_name, :string
    add_column :broker_approval_forms, :user_role, :string
    add_column :broker_approval_forms, :user_email, :string
    add_column :broker_approval_forms, :user_nmls_number, :string
    add_column :broker_approval_forms, :user_nmls_issued, :datetime
    add_column :broker_approval_forms, :user_nmls_expiration, :datetime
  end
end
