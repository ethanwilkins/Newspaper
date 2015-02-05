class BoardCodeId < ActiveRecord::Migration
  def change
    add_column :game_boards, :code_id, :integer
  end
end
