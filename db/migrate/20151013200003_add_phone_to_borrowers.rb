class AddPhoneToBorrowers < ActiveRecord::Migration
  def change
    add_column :loans, :borrower_phone, :string
    add_column :loans, :coborrower_phone, :string
  end
end
