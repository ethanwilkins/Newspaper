class CodesAsStrings < ActiveRecord::Migration
  def change
    change_column :codes, :code, :string
  end
end
