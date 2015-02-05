class AddBoardLocToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :board_loc, :integer
  end
end
