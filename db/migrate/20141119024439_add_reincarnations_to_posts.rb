class AddReincarnationsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :reincarnations, :integer
  end
end
