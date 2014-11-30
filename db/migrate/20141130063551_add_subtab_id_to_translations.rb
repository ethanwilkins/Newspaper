class AddSubtabIdToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :subtab_id, :integer
  end
end
