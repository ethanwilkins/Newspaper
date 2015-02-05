class DropAdverts < ActiveRecord::Migration
  def change
    drop_table :adverts
  end
end
