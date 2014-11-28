class ChangeTranslationRequestToRequested < ActiveRecord::Migration
  def change
    rename_column :translations, :request, :requested
  end
end
