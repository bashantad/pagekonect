class AddAddressToContents < ActiveRecord::Migration
  def change
    add_column :contents, :address, :string
  end
end
