class ListsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  protect_from_forgery :except => [:destroy]
  def index
    @user = User.find(current_user.id)
    @lists = @user.lists.order(:ingredient_name)
  end

  def create
    #レシピのidを整数に変換
    num = (params[:format]).to_i
    @recipe = Recipe.find(num)
    #レシピの材料を全て取り出す
    @ingredients = @recipe.ingredients
    list = List.new
    @ingredients.each do |ingredient|
      list = List.new(ingredient_name: ingredient.name, ingredient_quantity: ingredient.quantity, user_id: current_user.id)
      list.save
    end
    flash[:notice] = 'リストを追加しました'
    redirect_to "/users/#{current_user.id}"
  end

  def edit
    @list = List.find(params[:id])
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
  end

  private
  def list_params
    params.require(:list).permit(:ingredient_name, :ingredient_quantity, :user_id)
  end
end
