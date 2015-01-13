class AddRequiresApprovalToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :requires_approval, :boolean
  end
end
