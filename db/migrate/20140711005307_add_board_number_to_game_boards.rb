class AddBoardNumberToGameBoards < ActiveRecord::Migration
  def change
    add_column :game_boards, :board_number, :integer
  end
end
