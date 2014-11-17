class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :folder_id
      t.text :text
      t.boolean :seen
      t.timestamps
    end
  end
end
