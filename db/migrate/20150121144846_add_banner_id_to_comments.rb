class AddBannerIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :banner_id, :integer
  end
end
