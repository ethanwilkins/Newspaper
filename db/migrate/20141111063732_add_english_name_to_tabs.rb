class AddEnglishNameToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :english_name, :string
    add_column :subtabs, :english_name, :string
  end
end
