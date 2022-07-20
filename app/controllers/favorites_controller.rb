class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    num = params[:format].to_i
    @recipe = Recipe.find(num)
    @favorite = Favorite.new(user_id: current_user.id, recipe_id: @recipe.id)
    if Favorite.where(user_id: current_user.id, recipe_id: @recipe.id).exists?
      flash[:alert] = 'お気に入りにすでに登録されています'
      redirect_to recipe_path(@recipe)
    elsif @favorite.save
      flash[:notice] = 'お気に入りに登録しました'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'お気に入りに登録できませんでした'
      redirect_to recipe_path(@recipe)
    end
  end

  def destroy
    num = params[:id].to_i
    @recipe = Recipe.find(num)
    @favorite = Favorite.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    @favorite.destroy
    flash[:notice] = 'お気に入りを解除しました'
    redirect_to user_path(current_user.id)
  end

  private

  def favorite_params
    params.require(:favorite).merge(user_id, recipe_id)
  end
end
