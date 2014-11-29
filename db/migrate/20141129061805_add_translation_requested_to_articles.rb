class AddTranslationRequestedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :translation_requested, :boolean
  end
end
