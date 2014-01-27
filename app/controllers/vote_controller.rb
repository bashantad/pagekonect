class VoteController < ApplicationController
  before_filter :authenticate_user!

  def vote_up
    votable.liked_by current_user
    respond_to do |format|
      format.js { render 'vote.coffee' }
    end
  end

  def vote_down
    votable.unliked_by voter: current_user
    respond_to do |format|
      format.js { render 'vote.coffee' }
    end
  end

  private

    def votable
      @votable = params[:type].constantize.find(params[:id])
    end
end
