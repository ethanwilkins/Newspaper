class AddZipCodeToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :zip_code, :integer
    add_column :cards, :zip_code, :integer
    add_column :game_boards, :zip_code, :integer
  end
end
