class AddMadeMemberToMembers < ActiveRecord::Migration
  def change
    add_column :members, :made_member, :boolean
  end
end
