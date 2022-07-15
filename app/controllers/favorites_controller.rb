class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    num = (params[:format]).to_i
    @recipe = Recipe.find(num)
    @favorite = Favorite.new(user_id: current_user.id, recipe_id: @recipe.id)
    if @favorite.save
      flash[:notice] = 'お気に入りに登録しました'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'お気に入りに登録できませんでした'
      redirect_to recipe_path(@recipe)
    end
  end

  private
  def favorite_params
    params.require(:favorite).merge(user_id, recipe_id)
  end
end
