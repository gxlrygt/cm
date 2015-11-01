class AddIframeUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :iframe_url, :text
  end
end
