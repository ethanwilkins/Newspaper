class ChangeGroupGlobalToDefault < ActiveRecord::Migration
  def change
    rename_column :groups, :global, :default
  end
end
