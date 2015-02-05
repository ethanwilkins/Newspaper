class AddTranslationIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :translation_id, :integer
  end
end
