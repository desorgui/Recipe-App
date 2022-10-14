class ShoppingListController < ApplicationController
  # GET /shopping_list using the shopping list array that we created
  def index
    @shopping_lists = 'just index'
  end
# method to find food quantity in inventory_food table

  def inventory_food_quantity(food_id)
    inventory_food = InventoryFood.where(food_id: food_id, inventory_id: params[:id])
    inventory_food.quantity
  end

  # method to create shopping list

  def show
    @recipe_foods = RecipeFood.where(id: params[:recipe_id])
    @recipe_foods.each do |recipe_food|
      # if food is not in inventory_food table, add it to shopping list
      if InventoryFood.where(food_id: recipe_food.food_id, inventory_id: params[:id]).blank?
        @shopping_list << recipe_food.food_id
      else
        recipe_food.quantity > inventory_food_quantity(recipe_food.food_id)
        @difference = recipe_food.quantity - inventory_food_quantity(recipe_food.food_id)
        # add food to shopping list array
        @shopping_list << recipe_food.food_id
      end
  end
end