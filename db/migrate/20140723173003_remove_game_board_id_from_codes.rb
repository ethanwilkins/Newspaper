class RemoveGameBoardIdFromCodes < ActiveRecord::Migration
  def change
    remove_column :codes, :game_board_id
  end
end
