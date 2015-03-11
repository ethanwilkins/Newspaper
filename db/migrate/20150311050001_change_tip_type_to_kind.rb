class ChangeTipTypeToKind < ActiveRecord::Migration
  def change
    rename_column :tips, :tip_type, :kind
  end
end
