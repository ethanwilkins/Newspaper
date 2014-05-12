class CardAttributes < ActiveRecord::Migration
  def change
    add_column :cards, :code, :integer
    add_column :cards, :user_id, :integer
  end
end
