class AddBoardNumberToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :board_number, :integer
    remove_column :game_boards, :board_number
    
    add_column :users, :active, :boolean
  end
end
