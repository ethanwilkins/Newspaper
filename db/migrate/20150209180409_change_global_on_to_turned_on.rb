class ChangeGlobalOnToTurnedOn < ActiveRecord::Migration
  def change
    rename_column :features, :global_on, :turned_on
  end
end
