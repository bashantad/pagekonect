class AddWordsOfWisdomToUsers < ActiveRecord::Migration
  def change
    add_column :users, :words_of_wisdom, :text
    rename_column :users, :phone, :home_phone
    add_column :users, :mobile_phone, :string
    add_column :users, :fax, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :google_plus, :string
    add_column :users, :p_interest, :string
    add_column :users, :linked_in, :string
  end
end
