class AddPollIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :poll_id, :integer
  end
end
