class AddSubtabIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :subtab_id, :integer
  end
end
