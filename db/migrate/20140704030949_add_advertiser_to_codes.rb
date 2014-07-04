class AddAdvertiserToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :advertiser, :string
  end
end
