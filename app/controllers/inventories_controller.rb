class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[show edit update destroy]

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.where(user: current_user).includes(:user)
  end

  # GET /inventories/1 or /inventories/1.json
  def show
    @inventory = Inventory.includes(:user).find(params[:id])
    @inventory_food = @inventory.inventory_foods.includes(:food)
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end

  # GET /inventories/1/edit
  def edit; end

  # POST /inventories or /inventories.json
  def create
    @inventory = Inventory.new(params.require(:inventory).permit(:name, :description))
    @inventory.user = current_user
    if @inventory.save
      # format.html { redirect_to inventory_url(@inventory), notice: "Inventory was successfully created." }
      flash[:success] = 'New inventory has been created !!'
      redirect_to inventory_url(@inventory)
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url, notice: 'Inventory was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def inventory_params
    params.fetch(:inventory, {})
  end
end
