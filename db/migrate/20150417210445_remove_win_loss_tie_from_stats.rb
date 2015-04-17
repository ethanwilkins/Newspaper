class RemoveWinLossTieFromStats < ActiveRecord::Migration
  def change
  	remove_column :stats, :win
  	remove_column :stats, :loss
  	remove_column :stats, :tie
  end
end
