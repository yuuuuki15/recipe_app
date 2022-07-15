class MenusController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :redirect_to_root, only: [:create]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @menu = Menu.new(menu_params)
    if @menu.save
    flash[:notice] = '献立を追加しました'
    redirect_to ("/recipes/#{@recipe.id}")
    else
    flash[:alert] = '献立を追加できませんでした'
    redirect_to ("/recipes/#{@recipe.id}")
    end
  end

  private
  def menu_params
    params.require(:menu).permit(:date).merge(user_id: current_user.id, recipe_id: @recipe.id)
  end

  def redirect_to_root
    redirect_to root_path if current_user.nil?
  end
end
