class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.attachment :image
      t.references :user
      t.timestamps
    end
  end
end