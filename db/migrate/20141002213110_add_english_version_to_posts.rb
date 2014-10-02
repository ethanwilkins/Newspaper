class AddEnglishVersionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :english_version, :text
  end
end
