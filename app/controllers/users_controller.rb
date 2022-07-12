class UsersController < ApplicationController
  def show
    get_week
    @user = User.find(params[:id])
    @recipes = @user.recipes.order("created_at DESC")
  end

  def get_week
    wdays = ['(月)','(火)','(水)','(木)','(金)','(土)','(日)']
    @first_day = Date.today.beginning_of_week

    @week_days = []
    7.times do |x|
      day = @first_day + (x - 1)
      days = { wday: wdays[day.wday], month: day.month, date: day.day }
      @week_days.push(days)
    end
  end
end
