class CreateExternalSitePasswords < ActiveRecord::Migration
  def change
    create_table :external_site_passwords do |t|
    	t.string :external_site, null: false
    	t.text :password, null: false
    	t.references :user, index: true

    	t.timestamps
    end
  end
end
