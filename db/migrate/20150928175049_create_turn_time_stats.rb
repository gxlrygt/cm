class CreateTurnTimeStats < ActiveRecord::Migration
  def change
    create_table :turn_time_stats do |t|
      t.string :drawing_docs, null: false
      t.string :underwriting, null: false
      t.string :conditions, null: false
      t.string :funding, null: false
    end
  end
end
