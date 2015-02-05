class RemoveEnglishVersionsOfFields < ActiveRecord::Migration
  def change
    remove_column :articles, :english_version
    remove_column :articles, :english_title
    remove_column :posts, :english_version
    remove_column :tabs, :english_name
    remove_column :tabs, :english_description
    remove_column :events, :english_title
    remove_column :events, :english_body
  end
end
