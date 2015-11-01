class CreateLoanFeeWorksheets < ActiveRecord::Migration
  def self.up
    create_table :fee_worksheets do |t|
      t.integer    :loan_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :fee_worksheets
  end
end
