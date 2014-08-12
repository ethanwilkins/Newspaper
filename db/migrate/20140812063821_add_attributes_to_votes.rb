class AddAttributesToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :up, :boolean
    add_column :votes, :down, :boolean
    add_column :votes, :voter_id, :integer
    add_column :votes, :post_id, :integer
  end
end
