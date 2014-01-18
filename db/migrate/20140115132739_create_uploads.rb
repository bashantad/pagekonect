class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.attachment :photo
      t.string :photo_tag
      t.string :photo_description
      t.references :user, index: true

      t.timestamps
    end
  end
end
