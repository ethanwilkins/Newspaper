class AddGroupIdToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :group_id, :integer
  end
end
