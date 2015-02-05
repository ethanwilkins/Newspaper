class AddAdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :ad, :boolean
  end
end
