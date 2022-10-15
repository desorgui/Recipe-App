class ShoppingListController < ApplicationController
  def inventory_food_quantity(food_id)
    inventory_food = InventoryFood.where(food_id:, inventory_id: params[:id])
    inventory_food.quantity
  end

  # method to create shopping list

  def index
    @recipe_foods = RecipeFood.where(id: params[:recipe_id])
    @recipe_foods.each do |recipe_food|
      if recipe_food.quantity > inventory_food_quantity(recipe_food.food_id)
        @difference = recipe_food.quantity - inventory_food_quantity(recipe_food.food_id)
      end
      # add food to shopping list array
    end
    @shopping_list << recipe_food.food_id
  end
end
