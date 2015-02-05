class CardImageRestored < ActiveRecord::Migration
  def change
    add_column :cards, :image, :string
    add_column :cards, :title, :string
  end
end
