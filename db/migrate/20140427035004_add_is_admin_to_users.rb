class AddIsAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :sub_region, :string
  end
end
