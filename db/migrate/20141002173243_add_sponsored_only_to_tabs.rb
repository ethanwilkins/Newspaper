class AddSponsoredOnlyToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :sponsored_only, :boolean
  end
end
