class AddQueryToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :query, :string
    add_column :searches, :chosen_result_type, :string
    add_column :searches, :chosen_result_id, :integer
    add_column :searches, :user_id, :integer
  end
end
