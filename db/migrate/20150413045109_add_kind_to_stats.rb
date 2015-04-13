class AddKindToStats < ActiveRecord::Migration
  def change
    add_column :stats, :kind, :string
  end
end
