class AddCompanyToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :company, :string
  end
end
