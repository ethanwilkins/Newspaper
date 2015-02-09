class BringBackTurnedOnDefault < ActiveRecord::Migration
  def change
    change_column :features, :turned_on, :boolean, default: true
  end
end
