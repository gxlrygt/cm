class CreateTpoUserAccessRequests < ActiveRecord::Migration
  def up
    create_table :tpo_user_access_requests do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :role, null: false
      t.string :email, null: false
      t.string :nmls_number
      t.datetime :nmls_issued
      t.datetime :nmls_expiration

      t.integer :broker_approval_form_id, null: false

      t.timestamps
    end

    add_index :tpo_user_access_requests, :broker_approval_form_id, name: :tpo_baf_index

    remove_column :broker_approval_forms, :user_first_name
    remove_column :broker_approval_forms, :user_last_name
    remove_column :broker_approval_forms, :user_role
    remove_column :broker_approval_forms, :user_email
    remove_column :broker_approval_forms, :user_nmls_number
    remove_column :broker_approval_forms, :user_nmls_issued
    remove_column :broker_approval_forms, :user_nmls_expiration
  end

  def down
    drop_table :tpo_user_access_requests

    add_column :broker_approval_forms, :user_first_name, :string
    add_column :broker_approval_forms, :user_last_name, :string
    add_column :broker_approval_forms, :user_role, :string
    add_column :broker_approval_forms, :user_email, :string
    add_column :broker_approval_forms, :user_nmls_number, :string
    add_column :broker_approval_forms, :user_nmls_issued, :datetime
    add_column :broker_approval_forms, :user_nmls_expiration, :datetime
  end
end
