class FoodsController < ApplicationController
  before_action :set_food, only: %i[show destroy]
  before_action :authenticate_user!

  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def new
    @food = Food.new
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    if @food.save
      redirect_to food_url(@food), notice: 'Food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
end
