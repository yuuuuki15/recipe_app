class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @recipes = Recipe.all.order("created_at DESC").where(public_id: 1)
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

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :image, :amount, :tip, :public_id, 
      ingredients_attributes: [:id, :name, :quantity, :recipe_id, :_destroy], 
      descriptions_attributes: [:id, :text, :recipe_id, :_destroy]
    ).merge(user_id: current_user.id)
  end
end
