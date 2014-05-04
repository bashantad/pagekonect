class AddSuburbToUsers < ActiveRecord::Migration
  def change
    add_column :users, :suburb, :string
  end
end
