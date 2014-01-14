class AddOccupationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :occupation, :string
    add_column :users, :gender, :string
  end
end
