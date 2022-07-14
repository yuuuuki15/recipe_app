class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :ingredient_name, null: false
      t.string :ingredient_quantity
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
