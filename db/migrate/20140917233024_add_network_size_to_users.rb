class AddNetworkSizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :network_size, :integer
  end
end
