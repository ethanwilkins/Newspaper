class AddEnglishToUsers < ActiveRecord::Migration
  def change
    add_column :users, :english, :boolean
  end
end
