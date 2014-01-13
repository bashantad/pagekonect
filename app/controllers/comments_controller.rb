class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :check_ownership, only: [:destroy]
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = "Comment Created"
    else
      flash[:alert] = "Error Adding Comment"
    end

    redirect_to send("#{@comment.commentable.type.underscore}_path", @comment.commentable)

  end
  
  def destroy
    if @comment.destroy
      flash[:notice] = "Successfully deleted your comment"
    else
      flash[:alert] = "Error deleting comment"
    end
    redirect_to send("#{@comment.commentable.type.underscore}_path", @comment.commentable)
  end
  
  private
  
  def check_ownership
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      flash[:alert] = "You can't delete other people's comment"
      redirect_to send("#{@comment.commentable.type.underscore}_path", @comment.commentable)
    end
  end
  
  def comment_params
    params.require(:comment).permit(:description, :commentable_id, :commentable_type, :user_id)
  end
end
