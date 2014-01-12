class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)

    if comment.save
      flash[:notice] = "Comment Created"
    else
      flash[:alert] = "Error Adding Comment"
    end

    redirect_to send("#{comment.commentable.type.underscore}_path", comment.commentable)

  end

  private

  def comment_params
    params.require(:comment).permit(:description, :commentable_id, :commentable_type, :user_id)
  end
end
