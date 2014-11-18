class AddExpirationDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :expiration_date, :date
  end
end
