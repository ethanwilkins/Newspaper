class AddExpirationToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :expiration, :date
  end
end
