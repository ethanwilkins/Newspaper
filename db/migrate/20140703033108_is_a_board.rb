class IsABoard < ActiveRecord::Migration
  def change
    add_column :codes, :is_a_board, :boolean
  end
end
