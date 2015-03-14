class AddBrowserNameToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :browser_name, :string
    add_column :activities, :mobile, :boolean
  end
end
