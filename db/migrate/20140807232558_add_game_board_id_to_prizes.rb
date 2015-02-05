class AddGameBoardIdToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :game_board_id, :integer
  end
end
