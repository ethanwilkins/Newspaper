class CodeTitleToCardName < ActiveRecord::Migration
  def change
    rename_column :codes, :title, :card_name
  end
end
