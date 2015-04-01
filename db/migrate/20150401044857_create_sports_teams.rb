class CreateSportsTeams < ActiveRecord::Migration
  def change
    create_table :sports_teams do |t|

      t.timestamps null: false
    end
  end
end
