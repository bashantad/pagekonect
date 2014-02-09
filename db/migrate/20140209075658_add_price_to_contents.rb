class AddPriceToContents < ActiveRecord::Migration
  def change
    add_column :contents, :old_price, :float
    add_column :contents, :new_price, :float
  end
end
