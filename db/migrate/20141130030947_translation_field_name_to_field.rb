class TranslationFieldNameToField < ActiveRecord::Migration
  def change
    rename_column :translations, :field_name, :field
  end
end
