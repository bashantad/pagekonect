class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.string :ip_address
      t.integer :count
      t.references :content, index: true

      t.timestamps
    end
  end
end
