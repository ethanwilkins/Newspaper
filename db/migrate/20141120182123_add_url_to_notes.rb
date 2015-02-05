class AddUrlToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :url, :string
  end
end
