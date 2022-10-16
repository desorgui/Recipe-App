class AddPhotoToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :photo, :string
  end
end
