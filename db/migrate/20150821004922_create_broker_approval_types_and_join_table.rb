class CreateBrokerApprovalTypesAndJoinTable < ActiveRecord::Migration
  def change
    create_table :loan_types do |t|
      t.string :name
    end

    create_table :broker_approval_forms_loan_types do |t|
      t.integer :broker_approval_form_id
      t.integer :loan_type_id
      t.timestamp
    end

    add_index :broker_approval_forms_loan_types, [:broker_approval_form_id, :loan_type_id], name: :index_baf_loan_types_name

    add_column :broker_approval_forms, :created_at, :datetime
    add_column :broker_approval_forms, :updated_at, :datetime
    remove_column :broker_approval_forms, :i_want_to_get_approved_for
  end
end
