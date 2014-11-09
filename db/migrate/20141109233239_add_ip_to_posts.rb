class AddIpToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ip, :string
    add_column :tabs, :ip, :string
    add_column :subtabs, :ip, :string
    
    add_column :posts, :address, :string
    add_column :tabs, :address, :string
    add_column :subtabs, :address, :string
    
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
    add_column :tabs, :latitude, :float
    add_column :tabs, :longitude, :float
    add_column :subtabs, :latitude, :float
    add_column :subtabs, :longitude, :float
  end
end
