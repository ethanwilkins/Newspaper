class AddComboTypeToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :code_id, :integer
    add_column :prizes, :combo_type, :string
  end
end
