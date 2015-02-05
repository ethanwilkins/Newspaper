class AddEventIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :event_id, :integer
    add_column :members, :status, :string
  end
end
