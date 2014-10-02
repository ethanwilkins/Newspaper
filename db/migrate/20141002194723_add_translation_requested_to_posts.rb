class AddTranslationRequestedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :translation_requested, :boolean
  end
end
