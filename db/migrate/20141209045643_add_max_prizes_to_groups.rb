class AddMaxPrizesToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :max_prizes, :integer
  end
end
