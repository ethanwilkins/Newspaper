class AddGlobalOnToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :global_on, :boolean
    add_column :subtabs, :global_on, :boolean
  end
end
