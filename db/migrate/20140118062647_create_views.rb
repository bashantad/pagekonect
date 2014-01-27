class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.string :ip_address
      t.integer :count
      t.string :viewable_type, index: true
      t.integer :viewable_id, index: true

      t.timestamps
    end
  end
end
