class ReplaceAddress < ActiveRecord::Migration
  def change
    remove_column :posts, :address
    add_column :posts, :address, :string
    remove_column :tabs, :address
    add_column :tabs, :address, :string
    remove_column :subtabs, :address
    add_column :subtabs, :address, :string
  end
end
