class AddFieldNameToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :field_name, :string
  end
end
