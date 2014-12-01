class AddGroupIdToZips < ActiveRecord::Migration
  def change
    add_column :zips, :group_id, :integer
    add_column :users, :group_id, :integer
  end
end
