class AddImageNameToContents < ActiveRecord::Migration
  def change
    add_column :contents, :image_name, :string
  end
end
