class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :english
      t.string :spanish
      t.timestamps
    end
  end
end
