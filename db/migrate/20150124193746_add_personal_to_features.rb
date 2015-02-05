class AddPersonalToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :personal, :boolean
  end
end
