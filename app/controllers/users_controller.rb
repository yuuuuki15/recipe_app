class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order('created_at DESC')
    @menus = Menu.all
    @menu = Menu.new
    get_week(params[:beginning_of_week].to_date)
    @list = List.new
    favorites = Favorite.where(user_id: @user.id)
    @favorite_recipes = favorites.order('created_at DESC')
                                 .map { |favorite| Recipe.find(favorite.recipe_id) }
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile)
  end

  def get_week(first_day = Date.today.beginning_of_week)
    @first_day = first_day
    wdays = ['(月)', '(火)', '(水)', '(木)', '(金)', '(土)', '(日)']

    menus = Menu.where(user_id: @user.id, date: @first_day..@first_day + 6)

    @week_days = []
    7.times do |x|
      today_menus = []
      menus.each do |menu|
        today_menus.push(menu) if menu.date == @first_day + x
      end
      day = @first_day + x
      days = { wday: wdays[day.wday - 1], month: day.month, date: day.day, menu: today_menus }
      @week_days.push(days)
    end
  end
end
