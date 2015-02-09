class AddGlobalOnToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :global_on, :boolean
    remove_column :subtabs, :global_on
    remove_column :tabs, :global_on
  end
end
