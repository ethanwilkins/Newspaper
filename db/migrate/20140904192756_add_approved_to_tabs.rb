class AddApprovedToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :approved, :boolean
  end
end
