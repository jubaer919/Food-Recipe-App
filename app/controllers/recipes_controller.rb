class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:public]
  skip_before_action :verify_authenticity_token, only: :toggle_public

  def public
    @public_page = true
    @recipes = Recipe.where(public: true).order(created_at: :desc)
    render :index
  end

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    @recipe = set_recipe
    @recipe_foods = @recipe.recipe_foods.includes(:food).where(recipe_id: @recipe.id)
  end
end

def new
  @recipe = Recipe.new
end

def create
  @recipe = Recipe.new(recipe_params)
  @recipe.user = current_user
  if @recipe.save
    redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.'
  else
    render :new, status: :unprocessable_entity
  end
end
