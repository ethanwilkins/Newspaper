class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :user_id
      t.integer :tab_id
      t.string :action
      t.timestamps
    end
  end
end
