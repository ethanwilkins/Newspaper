class AddPostIdToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :tab_id, :integer
    add_column :translations, :post_id, :integer
    add_column :translations, :event_id, :integer
    add_column :translations, :article_id, :integer
  end
end
