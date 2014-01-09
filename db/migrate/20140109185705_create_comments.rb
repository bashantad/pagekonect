class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :description
      t.integer :commentable_id,    index: true
      t.string :commentable_type,   index: true
      t.references :user,           index: true

      t.timestamps
    end
  end
end
