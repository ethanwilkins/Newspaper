class RemoveCardTitleImage < ActiveRecord::Migration
  def change
    remove_column :cards, :title
    remove_column :cards, :image
  end
end
