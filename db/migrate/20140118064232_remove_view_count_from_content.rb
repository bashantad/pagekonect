class RemoveViewCountFromContent < ActiveRecord::Migration
  def change
    remove_column :contents, :view_count
  end
end
