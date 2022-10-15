class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[list_public show]
  before_action :set_recipe, only: %i[show edit update destroy]
  load_and_authorize_resource except: %i[list_public show]

  def shopping_list
    p params[:inventory_id]
    p params[:recipe_id]
  end

  def list_public
    @recipes = Recipe.where(public: true)
  end

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.by_user(current_user)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @foods = Food.all
    @ingredients = @recipe.recipe_foods.includes(:food)
    @inventories = Inventory.where(user: current_user)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :image)
  end
end
