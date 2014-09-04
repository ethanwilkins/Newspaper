class CreateSubtabs < ActiveRecord::Migration
  def change
    create_table :subtabs do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :icon
      t.timestamps
    end
  end
end
