class AddGlobalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :global, :boolean
  end
end
