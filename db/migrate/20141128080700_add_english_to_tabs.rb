class AddEnglishToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :english, :boolean
    add_column :posts, :english, :boolean
    add_column :articles, :english, :boolean
    add_column :events, :english, :boolean
  end
end
