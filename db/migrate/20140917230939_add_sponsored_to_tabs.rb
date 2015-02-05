class AddSponsoredToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :sponsored, :boolean
  end
end
