class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :redirect_to_root, only: [:create, :destroy]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'コメントを投稿できませんでした'
      render '/recipes/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to recipe_path(@comment.recipe)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, recipe_id: @recipe.id)
  end

  def redirect_to_root
    redirect_to root_path if current_user.nil?
  end
end
