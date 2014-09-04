class AddUserIdToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :user_id, :integer
  end
end
