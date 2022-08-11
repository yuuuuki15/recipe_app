class MenusController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :redirect_to_root, only: [:create]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @menu = Menu.new(menu_params)
    if begin @menu.save
    rescue Exception => e
      # 存在しない日付を指定した場合はエラーを表示する
      flash[:alert] = "予期せぬエラーが発生しました"
      STDERR.puts e.message
      return redirect_to recipe_path(@recipe)
    end
      flash[:notice] = '献立を追加しました'
      redirect_to user_path(current_user, beginning_of_week: Date.today.beginning_of_week)
    else
      flash[:alert] = '献立を追加できませんでした'
      redirect_to recipe_path(@recipe)
    end
  end

  def destroy
    @menu = Menu.find(params[:recipe_id])
    @menu.destroy
    flash[:notice] = '献立を削除しました'
    redirect_to user_path(current_user, beginning_of_week: Date.today.beginning_of_week)
  end

  private

  def menu_params
    params.require(:menu).permit(:date).merge(user_id: current_user.id, recipe_id: @recipe.id)
  end

  def redirect_to_root
    redirect_to root_path if current_user.nil?
  end
end
