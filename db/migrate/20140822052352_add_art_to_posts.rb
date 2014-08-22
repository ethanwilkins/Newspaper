class AddArtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :art, :boolean
  end
end
