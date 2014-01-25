class AddEventDateToContents < ActiveRecord::Migration
  def change
    add_column :contents, :event_date, :datetime
  end
end
