class RemoveLocationFromContents < ActiveRecord::Migration
  def change
    remove_column :contents, :location, :point, geographic: true
  end
end
