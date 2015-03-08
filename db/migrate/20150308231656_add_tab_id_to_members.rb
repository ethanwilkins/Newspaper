class AddTabIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :tab_id, :integer
    add_column :members, :subtab_id, :integer
  end
end
