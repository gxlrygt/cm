class CreateBrokerApprovalForms < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :code, null: false, unique: true
      t.string :name, null: false
    end

    add_index :states, :code, unique: true

    create_table :broker_approval_forms do |t|
      t.text :company, null: false
      t.string :company_type, null: false
      t.string :dba
      t.string :company_president, null: false
      t.string :broker_of_record, null: false
      t.string :nmls, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.references :state, null: false
      t.string :zip, null: false
      t.string :primary_contact, null: false
      t.string :title, null: false
      t.string :phone
      t.text :i_want_to_get_approved_for, null: false
      t.text :how_did_you_find_us, null: false
      t.text :how_did_you_find_us_account_executive_name
      t.text :how_did_you_find_us_other
      t.string :lender_paid_compensation_percentage, null: false
      t.string :maximum_compensation, null: false
      t.string :user
      t.string :role
      t.text :email
      t.string :status
    end
  end
end
