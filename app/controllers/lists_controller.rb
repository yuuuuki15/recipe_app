class ListsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @lists = @user.lists
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

  private
  def list_params
    params.require(:list).permit(:ingredient_name, :ingredient_quantity, :user_id)
  end
end
