class AddTranslationRequestedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :english_title, :string
    add_column :events, :english_body, :string
    add_column :events, :translation_requested, :boolean
  end
end
