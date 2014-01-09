class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|

      t.timestamps
    end
  end
end
