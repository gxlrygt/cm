class AddRegardingToContactForms < ActiveRecord::Migration
  def change
    add_column :contact_forms, :regarding, :string
  end
end
