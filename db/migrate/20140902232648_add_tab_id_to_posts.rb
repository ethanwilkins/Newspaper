class AddTabIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tab_id, :integer
    remove_column :articles, :tab_id
  end
end
