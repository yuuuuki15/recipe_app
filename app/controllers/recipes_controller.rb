class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_root, only: [:edit, :update, :destroy]
  protect_from_forgery :except => [:destroy]

  
  def index
    @recipes = Recipe.all.order("created_at DESC").where(public_id: 1)
    .or(Recipe.all.order("created_at DESC").where(user_id: current_user.id))
  end

  def new
    @recipe = Recipe.new
    @ingredient = @recipe.ingredients.build
    @description = @recipe.descriptions.build
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
  end

  def edit
    @ingredient = @recipe.ingredients.build
    @description = @recipe.descriptions.build
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :image, :amount, :tip, :public_id, 
      ingredients_attributes: [:id, :name, :quantity, :recipe_id, :_destroy], 
      descriptions_attributes: [:id, :text, :recipe_id, :_destroy]
    ).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def redirect_to_root
    redirect_to root_path if @recipe.user_id != current_user.id
  end
end
