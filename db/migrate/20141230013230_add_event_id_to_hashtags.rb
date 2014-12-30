class AddEventIdToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :event_id, :integer
  end
end
