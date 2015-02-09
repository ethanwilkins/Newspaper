class ReinitializeTurnedOn < ActiveRecord::Migration
  def change
    remove_column :features, :turned_on
    add_column :features, :turned_on, :boolean
  end
end
