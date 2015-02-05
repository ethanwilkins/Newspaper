class AddTranslationRequestedToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :translation_requested, :boolean
  end
end
