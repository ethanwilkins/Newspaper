class DisableTurnedOnDefault < ActiveRecord::Migration
  def change
    change_column :features, :turned_on, :boolean, default: nil
  end
end
