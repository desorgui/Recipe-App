class ShoppingListController < ApplicationController
  def inventory_food_quantity(food_id)    
    inventory_id = 15
    @inventory_food = InventoryFood.where(food_id:food_id, inventory_id:inventory_id)
    @inventory_food[0].quantity
  end

  def index
    recipe_id = 1
    inventory_id = 15
    @recipe_foods = RecipeFood.where(recipe_id:recipe_id)
    @recipe_foods.each do |recipe_food|
      @shopping_list ||= []       
      food_to_find = Food.find(recipe_food.food_id)
      if InventoryFood.where(food_id: recipe_food.food_id, inventory_id:inventory_id).blank?
        @shopping_list << {food: food_to_find, quantity: recipe_food.quantity}
      else
        if recipe_food.quantity > inventory_food_quantity(recipe_food.food_id)
          @difference = recipe_food.quantity - inventory_food_quantity(recipe_food.food_id)
          # add food to shopping list array
          @shopping_list << {food: food_to_find, quantity:@difference}
        end
      end
    end
  end
end