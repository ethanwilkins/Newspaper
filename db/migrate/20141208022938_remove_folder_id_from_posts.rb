class RemoveFolderIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :folder_id
  end
end
