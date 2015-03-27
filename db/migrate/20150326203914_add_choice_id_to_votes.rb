class AddChoiceIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :choice_id, :integer
    add_column :choices, :poll_id, :integer
  end
end
