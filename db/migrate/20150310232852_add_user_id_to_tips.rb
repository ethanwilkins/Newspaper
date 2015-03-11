class AddUserIdToTips < ActiveRecord::Migration
  def change
    add_column :tips, :user_id, :integer
    add_column :tips, :tip_type, :string
    add_column :tips, :tip, :text
  end
end
