class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.float :preparation_time, null: false, default: 0
      t.float :cooking_time, null: false, default: 0
      t.text :description, null: false
      t.boolean :public, null: false, default: true
      
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
