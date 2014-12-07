class RemoveSalesFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :sales_dialogue
  end
end
