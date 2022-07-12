class MenusController < ApplicationController
  def create
    @menu = Menu.new(menu_params)
    @menu.save
    flash[:success] = '献立を追加しました'
  end

  private
  def menu_params
    params.require(:menu).permit(:date, :user_id, :recipe_id)
  end
end
