class CardGameboardId < ActiveRecord::Migration
  def change
    add_column :cards, :game_board_id, :integer
  end
end
