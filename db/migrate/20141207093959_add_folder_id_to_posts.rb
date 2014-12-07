class AddFolderIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :folder_id, :integer
  end
end
