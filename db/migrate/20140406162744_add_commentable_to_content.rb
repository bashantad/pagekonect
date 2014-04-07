class AddCommentableToContent < ActiveRecord::Migration
  def change
    add_column :contents, :commentable, :boolean, default: false
  end
end
