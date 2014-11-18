class RemoveJokeArtFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :joke
    remove_column :posts, :art
    remove_column :posts, :question
  end
end
