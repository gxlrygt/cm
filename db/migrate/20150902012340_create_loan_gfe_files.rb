class CreateLoanGfeFiles < ActiveRecord::Migration
  def self.up
    create_table :gfe_files do |t|
      t.integer    :loan_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :gfe_files
  end
end
