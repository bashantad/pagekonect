class AddLocationToContent < ActiveRecord::Migration
  def change
    add_column :contents, :location, :point, geographic: true
  end
end
