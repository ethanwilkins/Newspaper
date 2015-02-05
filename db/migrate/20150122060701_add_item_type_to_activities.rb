class AddItemTypeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :item_type, :string
  end
end
