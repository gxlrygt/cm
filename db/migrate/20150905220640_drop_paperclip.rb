class DropPaperclip < ActiveRecord::Migration
  def change
    remove_column :loans, :gfe_file_file_name
    remove_column :loans, :gfe_file_content_type
    remove_column :loans, :gfe_file_file_size
    remove_column :loans, :gfe_file_updated_at
    remove_column :loans, :fee_worksheet_file_name
    remove_column :loans, :fee_worksheet_content_type
    remove_column :loans, :fee_worksheet_file_size
    remove_column :loans, :fee_worksheet_updated_at
    drop_table :gfe_files
    drop_table :fee_worksheets
  end
end
