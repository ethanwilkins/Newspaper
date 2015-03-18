class AddSkippedTourToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skipped_tour, :boolean
  end
end
