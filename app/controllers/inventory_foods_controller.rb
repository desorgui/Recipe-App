class InventoryFoodsController < ApplicationController
    before_action :set_inventory_food, only: %i[ show edit update destroy ]
  
    # GET /inventory_foods or /inventory_foods.json
    def index
      # @inventory_foods = Inventory_food.all
      @current_inventory = Inventory.find(params[:inventory_id])
      @food_list = Food.where(user_id: current_user.id)
      @inventory_food_list = InventoryFood.where(inventory_id: params[:inventory_id])
    end
  
    # GET /inventory_foods/1 or /inventory_foods/1.json
    def show
    end
  
    # GET /inventory_foods/new
    def new
      @inventory = Inventory.includes(:user).find(params[:id])
      @inventory_food = InventoryFood.new
      @params = params
    end
  
    # GET /inventory_foods/1/edit
    def edit
    end
  
    # # POST /inventory_foods or /inventory_foods.json
    # def create
    #   @inventory_food = Inventory_food.new(params.require(:inventory_food).permit(:name))
    #   @inventory_food.user = current_user
    #   if @inventory_food.save
    #     # format.html { redirect_to inventory_food_url(@inventory_food), notice: "Inventory_food was successfully created." }
    #     flash[:success] = 'New inventory_food has been created !!'
    #     redirect_to inventory_food_url(@inventory_food)
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #   end
    # end

    def create
        food_list = params[:inventory_food][:food_list]
        food_list = food_list.drop(1)
        food_list.each do |food|
          next unless InventoryFood.where(food_id: food.to_i, inventory_id: params[:id]).blank?
    
          new_inventory_food = InventoryFood.new(food_id: food.to_i, quantity: params[:inventory_food][:quantity],
                                                 inventory_id: params[:id])
          new_inventory_food.save
        end
        redirect_to inventory_path
    end
    # def create
    #   @inventory_food = Inventory_food.new(params.require(:inventory_food).permit(:name).merge(user_id: current_user.id))
  
    #   respond_to do |format|
    #     if @inventory_food.save
    #       format.html { redirect_to inventory_food_url(@inventory_food), notice: "Inventory_food was successfully created." }
    #       # format.json { render :show, status: :created, location: @inventory_food }
    #     else
    #       format.html { render :new, status: :unprocessable_entity }
    #       # format.json { render json: @inventory_food.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end
  
    # DELETE /inventory_foods/1 or /inventory_foods/1.json
    def destroy
      @inventory_food.destroy
  
      respond_to do |format|
        format.html { redirect_to inventory_foods_url, notice: "Inventory_food was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_inventory_food
        @inventory_food = InventoryFood.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def inventory_food_params
        params.fetch(:inventory_food, {})
      end
  end
  