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
    redirect_to user_path(current_user, beginning_of_week: Date.today.beginning_of_week)
  end

  def edit
    @user = User.find(current_user.id)
    # @user.lists = @user.lists.order(ingredient_name: "DESC")
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(edit_list_params)
      redirect_to lists_path
    else
      render :index
    end
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

  private

  def list_params
    params.require(:list).permit(:ingredient_name, :ingredient_quantity, :user_id)
  end

  def edit_list_params
    params.require(:user).permit(lists_attributes: [:id, :ingredient_name, :ingredient_quantity, :_destroy],)
  end
end
