class AddJokeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :joke, :boolean
  end
end
