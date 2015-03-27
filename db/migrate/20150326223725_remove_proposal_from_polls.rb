class RemoveProposalFromPolls < ActiveRecord::Migration
  def change
    remove_column :polls, :proposal
    remove_column :polls, :kind
  end
end
