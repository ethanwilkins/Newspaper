class CardCodeId < ActiveRecord::Migration
  def change
    rename_column :cards, :code, :code_id
  end
end
