class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.integer :amount, null: false
      t.text :tip
      t.integer :public_id, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
