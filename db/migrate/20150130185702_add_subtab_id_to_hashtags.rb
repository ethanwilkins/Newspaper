class AddSubtabIdToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :subtab_id, :integer
  end
end
