class ChangeRequestedBackToRequest < ActiveRecord::Migration
  def change
    rename_column :translations, :requested, :request
  end
end
