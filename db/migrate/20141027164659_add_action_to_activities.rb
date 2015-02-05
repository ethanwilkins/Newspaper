class AddActionToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :action, :string
    add_column :activities, :ip, :string
    add_column :activities, :info_text, :text
    add_column :activities, :data_string, :string
    add_column :activities, :item_id, :integer
  end
end
