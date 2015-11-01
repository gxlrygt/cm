class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.text :name, null: false
    	t.string :category, index: true
    	t.string :subcategory, index: true
    	t.text :description
    	t.text :table_html, null: false
    	t.timestamps
    end
  end
end
