class AddGroupIdToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :group_id, :integer
  end
end
