class AddBannerImageToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :banner_image
  end
end
