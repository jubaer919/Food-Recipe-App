class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @food }
    end
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    if @food.save
      redirect_to food_url(@food), notice: 'Food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # This action is used to render the edit form
  end

  def update
    if @food.update(food_params)
      redirect_to food_url(@food), notice: 'Food was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find_by(id: params[:id])

    if @food
      @food.destroy
      redirect_to foods_url, notice: 'Food was successfully destroyed.'
    else
      redirect_to foods_url, alert: 'Food not found.'
    end
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
