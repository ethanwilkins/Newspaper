class AddSubtabIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :subtab_id, :integer
  end
end
