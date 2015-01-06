class AddTabIdToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :tab_id, :integer
  end
end
