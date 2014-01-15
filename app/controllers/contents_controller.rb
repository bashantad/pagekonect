class ContentsController < ApplicationController

  before_filter :authenticate_user!

  def vote_up
    content.liked_by current_user
  end

  def vote_down
    content.unliked_by current_user
  end

  private

    def content
      Content.find(params[:id])
    end
end