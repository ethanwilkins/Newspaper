class AddDoubleEliminationToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :double_elimination, :boolean
  end
end
