class SwitchBackToPaperclip < ActiveRecord::Migration
  def up
    remove_column :loans, :gfe_file
    remove_column :loans, :fee_worksheet

    add_attachment :loans, :gfe_file
    add_attachment :loans, :fee_worksheet
  end

  def down
    remove_attachment :loans, :gfe_file
    remove_attachment :loans, :fee_worksheet

    add_column :loans, :gfe_file, :oid
    add_column :loans, :fee_worksheet, :oid
  end
end
