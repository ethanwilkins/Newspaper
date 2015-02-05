class CardTitleImage < ActiveRecord::Migration
  def change
    add_column :cards, :title, :string
    add_column :cards, :image, :string
  end
end
