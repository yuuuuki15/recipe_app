class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    @user = User.find(current_user.id)
    favorites = Favorite.where(user_id: @user.id)
    @favorite_recipes = favorites.order('created_at DESC')
                                 .map { |favorite| Recipe.find(favorite.recipe_id) }
  end

  def create
    num = params[:format].to_i
    @recipe = Recipe.find(num)
    @favorite = Favorite.new(user_id: current_user.id, recipe_id: @recipe.id)
    if Favorite.where(user_id: current_user.id, recipe_id: @recipe.id).exists?
      flash[:alert] = 'マイフォルダすでに登録されています'
      redirect_to recipe_path(@recipe)
    elsif @favorite.save
      flash[:notice] = 'マイフォルダに追加しました'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'マイフォルダに追加できませんでした'
      redirect_to recipe_path(@recipe)
    end
  end

  def destroy
    num = params[:id].to_i
    @recipe = Recipe.find(num)
    @favorite = Favorite.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    @favorite.destroy
    flash[:notice] = 'マイフォルダから削除しました'
    redirect_to user_path(current_user.id)
  end

  private

  def favorite_params
    params.require(:favorite).merge(user_id, recipe_id)
  end
end
