class AddFacebookUrlToContents < ActiveRecord::Migration
  def change
    add_column :contents, :facebook_url, :string
    add_column :contents, :twitter_url, :string
    add_column :contents, :start_time, :string
    add_column :contents, :end_time, :string
  end
end
