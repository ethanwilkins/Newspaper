class AddApprovedToSubtabs < ActiveRecord::Migration
  def change
    add_column :subtabs, :approved, :boolean
    add_column :posts, :subtab_id, :integer
  end
end
