class ChangeColumnNameFromContents < ActiveRecord::Migration
  def change
    rename_column :contents, :image_name, :image_description
  end
end
