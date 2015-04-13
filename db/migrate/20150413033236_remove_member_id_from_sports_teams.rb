class RemoveMemberIdFromSportsTeams < ActiveRecord::Migration
  def change
    remove_column :sports_teams, :member_id
  end
end
