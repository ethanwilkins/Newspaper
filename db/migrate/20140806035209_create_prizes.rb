class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.integer :user_id
      t.integer :cash_prize
      t.string :winning_combo
      t.timestamps
    end
  end
end
