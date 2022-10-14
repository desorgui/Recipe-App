class RecipeFoodsController < ApplicationController 
  def create
    recipe_id = params[:recipe_id]
    ingredients = params[:ingredients]

    ingredients.values.each do |ingredient|
      RecipeFood.create(
        quantity: ingredient[:quantity],
        recipe_id:,
        food_id: ingredient[:id]
      )
    end

    redirect_to recipe_path(recipe_id)
  end

  def destroy
    recipe_id = params[:recipe_id]
    food_id = params[:id]

    RecipeFood.find_by(recipe_id:, food_id:).destroy

    redirect_to recipe_path(recipe_id)
  end
end