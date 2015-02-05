class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.date :date
      t.time :time
      t.boolean :approved
      t.timestamps
    end
  end
end
