class AddTabIdToSubtabs < ActiveRecord::Migration
  def change
    add_column :subtabs, :tab_id, :integer
  end
end
