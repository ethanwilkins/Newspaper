class CreateGameBoards < ActiveRecord::Migration
  def change
    create_table :game_boards do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
