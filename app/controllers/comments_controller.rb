class CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    binding.pry
    if @comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'コメントを投稿できませんでした'
      render '/recipes/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, recipe_id: @recipe.id)
  end
end
