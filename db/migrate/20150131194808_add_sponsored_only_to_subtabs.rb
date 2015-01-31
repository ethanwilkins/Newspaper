class AddSponsoredOnlyToSubtabs < ActiveRecord::Migration
  def change
    add_column :subtabs, :sponsored_only, :boolean
    add_column :subtabs, :sponsored, :boolean
    add_column :subtabs, :translation_requested, :boolean
    add_column :subtabs, :company, :string
    remove_column :subtabs, :english_name
    add_column :subtabs, :english, :boolean
  end
end
