class AddArticleIdToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :article_id, :integer
    add_column :hashtags, :comment_id, :integer
    add_column :hashtags, :user_id, :integer
  end
end
