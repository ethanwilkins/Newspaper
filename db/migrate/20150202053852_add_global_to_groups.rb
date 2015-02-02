class AddGlobalToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :global, :boolean
  end
end
