class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @ingredient = @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.valid?
      @recipe.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :image, :amount, :method, :tip, :public_id, ingredients_attributes: [:id, :name, :quantity, :recipe_id, :_destroy]).merge(user_id: current_user.id)
  end
end
