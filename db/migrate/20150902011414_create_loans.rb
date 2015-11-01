class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :account_executive
      t.attachment :gfe_file
      t.attachment :fee_worksheet
      t.string :lender_or_borrower_paid
      t.boolean :underwriting_fee_buyout
      t.string :lender_compensation
      
      t.string :broker_first_name
      t.string :broker_last_name
      t.string :broker_phone
      t.string :broker_email
      
      t.string :processor_first_name
      t.string :processor_last_name
      t.string :processor_phone
      t.string :processor_email

      t.text :address
      t.string :city
      t.references :state
      t.string :zip

      t.string :borrower_first_name
      t.string :borrower_last_name
      t.string :borrower_email
      t.string :borrower_mid_fico_score

      t.string :coborrower_first_name
      t.string :coborrower_last_name
      t.string :coborrower_email
      t.string :coborrower_mid_fico_score

      t.decimal :property_value, precision: 15, scale: 4
      t.decimal :loan_amount, precision: 15, scale: 4
      t.decimal :disclosed_rate_pct, precision: 15, scale: 4
      t.string :ltv
      t.string :cltv

      t.boolean :impounds_or_escrows

      t.string :loan_type
      t.string :transaction_type
      t.string :fha_underwriting_type
      t.string :term
      t.string :property_type

      t.boolean :appraisal_needed
      t.string :occupancy
      t.text :additional_details

      t.timestamps
    end
  end
end
