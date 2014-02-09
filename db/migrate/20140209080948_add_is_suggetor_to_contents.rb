class AddIsSuggetorToContents < ActiveRecord::Migration
  def change
    add_column :contents, :is_suggestor, :boolean
  end
end
