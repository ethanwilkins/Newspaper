class AddPostIdToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :post_id, :integer
  end
end
