class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :country
      t.string :state

      t.timestamps
    end
  end
end
