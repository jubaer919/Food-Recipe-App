class FoodsController < ApplicationController
  before_action :set_food, only: %i[show destroy]
  before_action :authenticate_user!

  def index
    @foods = Food.where(user_id: current_user.id)
  end
end
