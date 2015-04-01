class CreateSportsMatches < ActiveRecord::Migration
  def change
    create_table :sports_matches do |t|

      t.timestamps null: false
    end
  end
end
