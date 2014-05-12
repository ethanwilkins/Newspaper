class ArticleAttributes < ActiveRecord::Migration
  def change
    add_column :articles, :title, :string
    add_column :articles, :body, :text
    add_column :articles, :user_id, :integer
  end
end
