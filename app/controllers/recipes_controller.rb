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
end
