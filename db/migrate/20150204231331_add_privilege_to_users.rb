class AddPrivilegeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privilege, :string
  end
end
