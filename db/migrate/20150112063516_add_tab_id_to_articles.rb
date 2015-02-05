class AddTabIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tab_id, :integer
    add_column :events, :tab_id, :integer
  end
end
