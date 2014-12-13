class AddDevToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dev, :boolean
    add_column :users, :test, :boolean
  end
end
