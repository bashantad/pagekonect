class AddGooglePlusUrlToContents < ActiveRecord::Migration
  def change
    add_column :contents, :google_plus_url, :string
  end
end
