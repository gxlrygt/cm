class RemoveNonNullConstraintOnExternalSites < ActiveRecord::Migration
  def up
  	change_column :external_site_passwords, :password, :text, null: true
  	add_column :external_site_passwords, :username, :string
  end

  def down
  	change_column :external_site_passwords, :password, :text, null: false
  	remove_column :external_site_passwords, :username
  end
end
