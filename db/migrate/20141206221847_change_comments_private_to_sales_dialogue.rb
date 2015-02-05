class ChangeCommentsPrivateToSalesDialogue < ActiveRecord::Migration
  def change
    rename_column :comments, :private, :sales_dialogue
  end
end
