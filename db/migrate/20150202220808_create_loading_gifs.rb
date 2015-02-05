class CreateLoadingGifs < ActiveRecord::Migration
  def change
    create_table :loading_gifs do |t|
      t.string :image
      t.integer :tab_id
      t.integer :subtab_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
