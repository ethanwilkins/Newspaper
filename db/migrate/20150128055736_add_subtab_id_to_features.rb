class AddSubtabIdToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :subtab_id, :integer
  end
end
