class AddKindToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :kind, :string
  end
end
