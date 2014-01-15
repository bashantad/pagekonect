class ContentsController < ApplicationController

  before_filter :authenticate_user!

  def vote_up
    content.liked_by current_user
    respond_to do |format|
      format.js { render 'vote.coffee' }
    end
  end

  def vote_down
    content.unliked_by voter: current_user
    respond_to do |format|
      format.js { render 'vote.coffee' }
    end
  end

  private

    def content
      @content = Content.find(params[:id])
    end
end