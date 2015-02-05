class AddHyperlinkToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :hyperlink, :string
  end
end
