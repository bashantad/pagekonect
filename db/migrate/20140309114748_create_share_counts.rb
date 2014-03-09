class CreateShareCounts < ActiveRecord::Migration
  def change
    create_table :share_counts do |t|
      t.integer :count
      t.string :site_name
      t.string :share_countable_type, index: true
      t.string :share_countable_id, index: true

      t.timestamps
    end
  end
end
