class AddEnglishDescriptionToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :english_description, :string
  end
end
