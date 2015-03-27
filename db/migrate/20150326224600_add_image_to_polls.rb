class AddImageToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :image, :string
  end
end
