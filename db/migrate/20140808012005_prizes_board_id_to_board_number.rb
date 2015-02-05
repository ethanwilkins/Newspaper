class PrizesBoardIdToBoardNumber < ActiveRecord::Migration
  def change
    rename_column :prizes, :game_board_id, :board_number
  end
end
