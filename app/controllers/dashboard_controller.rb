class DashboardController < ApplicationController

  def home
  end

  def index
  	@users = User.all
  end

  def public
  	
  end

  def contact_us
  	
  end

  def about_us
  	
  end

  def business
  	
  end
end
