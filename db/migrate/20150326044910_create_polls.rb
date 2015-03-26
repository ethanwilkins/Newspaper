class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :user_id
      t.integer :tab_id
      t.integer :subtab_id
      t.text :question
      t.text :proposal
      t.timestamps null: false
    end
  end
end
