class AddWinToStats < ActiveRecord::Migration
  def change
    add_column :stats, :win, :boolean
    add_column :stats, :loss, :boolean
    add_column :stats, :tie, :boolean
    add_column :stats, :winning_score, :integer
    add_column :stats, :losing_score, :integer
  end
end
