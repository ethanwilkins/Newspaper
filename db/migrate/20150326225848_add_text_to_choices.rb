class AddTextToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :text, :text
  end
end
