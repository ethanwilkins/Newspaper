class CodeBoard < ActiveRecord::Migration
  def change
    add_column :codes, :game_board_id, :integer
  end
end
