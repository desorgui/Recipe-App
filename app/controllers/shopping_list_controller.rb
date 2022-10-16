class ShoppingListController < ApplicationController
  def inventory_food_quantity(food_id)
    inventory_id = params[:inventory_id]
    @inventory_food = InventoryFood.where(food_id:, inventory_id:)
    @inventory_food[0].quantity
  end

  def index
    @recipe_to_find = params[:recipe_id]
    @inventory_to_find = params[:inventory_id]

    @recipe_foods = RecipeFood.where(recipe_id: @recipe_to_find)
    @total_price = 0
    @recipe_foods.each do |recipe_food|
      @shopping_list ||= []
      food_to_find = Food.find(recipe_food.food_id)
      if InventoryFood.where(food_id: recipe_food.food_id, inventory_id: @inventory_to_find).blank?
        @total_price = (food_to_find.price * recipe_food.quantity) + @total_price
        @shopping_list << { food: food_to_find, quantity: recipe_food.quantity }
      elsif recipe_food.quantity > inventory_food_quantity(recipe_food.food_id)
        @difference = recipe_food.quantity - inventory_food_quantity(recipe_food.food_id)
        # add food to shopping list array
        @total_price = (food_to_find.price * @difference) + @total_price
        @shopping_list << { food: food_to_find, quantity: @difference }
      end
    end

    render 'shopping_list/index'
  end
end
