class AddBoardLocToCards < ActiveRecord::Migration
  def change
    add_column :cards, :board_loc, :integer
  end
end
