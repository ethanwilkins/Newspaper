class AddHiddenToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :hidden, :boolean
  end
end
