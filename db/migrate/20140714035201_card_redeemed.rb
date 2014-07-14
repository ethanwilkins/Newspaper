class CardRedeemed < ActiveRecord::Migration
  def change
    add_column :cards, :redeemed, :boolean
  end
end
