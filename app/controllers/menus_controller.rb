class MenusController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @menu = Menu.new(menu_params)
    @menu.save
    flash[:success] = '献立を追加しました'
  end

  private
  def menu_params
    params.require(:menu).permit(:date).merge(user_id: current_user.id, recipe_id: @recipe.id)
  end
end
