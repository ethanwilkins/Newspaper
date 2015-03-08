class AddInviteOnlyToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :invite_only, :boolean
    add_column :subtabs, :invite_only, :boolean
  end
end
