class AddEnglishVersionToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :english_version, :text
  end
end
