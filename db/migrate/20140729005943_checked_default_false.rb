class CheckedDefaultFalse < ActiveRecord::Migration
  def change
    change_column :notes, :checked, :boolean, default: false
  end
end
