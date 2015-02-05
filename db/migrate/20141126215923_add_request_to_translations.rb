class AddRequestToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :request, :boolean
  end
end
