class AddRepopulationIntervalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :repopulation_interval, :integer
  end
end
