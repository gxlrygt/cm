class SetupCarrierwave < ActiveRecord::Migration
  def change
    add_column :loans, :gfe_file, :oid
    add_column :loans, :fee_worksheet, :oid
  end
end
