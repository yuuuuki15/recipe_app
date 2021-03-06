class ListsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  protect_from_forgery except: [:destroy]
  def index
    @user = User.find(current_user.id)
    @lists = @user.lists.order(:ingredient_name)
  end

  def create
    # レシピのidを整数に変換
    num = params[:format].to_i
    @recipe = Recipe.find(num)
    # レシピの材料を全て取り出す
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

  def check
    @list = List.find(params[:id])
    # チェックがついていたら外し、ついていなかったらつける
    if @list.check == 0
      @list.update(check: 1)
    else
      @list.update(check: 0)
    end
  end

  def edit
    @user = User.find(current_user.id)
    @lists = @user.lists.order(:ingredient_name)
  end

  def update
    binding.pry
    @list = List.find(params[:id])
    @list.update(list_params)
  end

  private

  def list_params
    params.require(:list).permit(:ingredient_name, :ingredient_quantity, :user_id)
  end
end
