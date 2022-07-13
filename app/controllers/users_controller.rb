class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order("created_at DESC")
    @menus = Menu.all
    get_week
  end

  def get_week
    wdays = ['(月)','(火)','(水)','(木)','(金)','(土)','(日)']
    @first_day = Date.today.beginning_of_week

    menus = Menu.where(user_id: @user.id, date: @first_day..@first_day + 6)

    @week_days = []
    7.times do |x|
      today_menus = []
      menus.each do |menu|
        today_menus.push(menu.recipe) if menu.date == @first_day + x
      end
      day = @first_day + (x)
      days = { wday: wdays[day.wday - 1], month: day.month, date: day.day, menu: today_menus }
      @week_days.push(days)
    end
  end
end
