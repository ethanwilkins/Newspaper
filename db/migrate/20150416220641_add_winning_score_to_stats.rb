class AddWinningScoreToStats < ActiveRecord::Migration
  def change
    add_column :stats, :winning_score, :integer
    add_column :stats, :losing_score, :integer
    add_column :stats, :finished, :boolean
    add_column :stats, :image, :string
  end
end
