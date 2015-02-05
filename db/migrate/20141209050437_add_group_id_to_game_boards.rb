class AddGroupIdToGameBoards < ActiveRecord::Migration
  def change
    add_column :game_boards, :group_id, :integer
  end
end
