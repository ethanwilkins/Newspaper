class AddSaleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sale, :boolean
  end
end
