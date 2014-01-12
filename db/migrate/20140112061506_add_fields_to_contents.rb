class AddFieldsToContents < ActiveRecord::Migration
  def change
    add_column :contents, :title, :string
    add_column :contents, :description, :text
    add_column :contents, :url, :string
    add_column :contents, :is_searchable, :boolean
    add_column :contents, :view_count, :integer
    add_column :contents, :type, :string
    add_attachment :contents, :image
  end
end
