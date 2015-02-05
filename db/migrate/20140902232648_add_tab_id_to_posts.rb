class AddTabIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tab_id, :integer
  end
end
