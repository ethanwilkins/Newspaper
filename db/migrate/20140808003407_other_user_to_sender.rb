class OtherUserToSender < ActiveRecord::Migration
  def change
    rename_column :notes, :other_user_id, :sender_id
  end
end
