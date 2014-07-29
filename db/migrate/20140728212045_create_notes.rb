class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :message
      t.string :action
      t.boolean :checked
      t.integer :item_id
      t.integer :user_id
      t.integer :other_user_id
      
      t.timestamps
    end
  end
end
