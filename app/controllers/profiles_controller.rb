class ProfilesController < ApplicationController
  before_filter :set_user
  before_filter :authenticate_user!, :except => [:view]
  layout 'user'
  
  def upload_banner
    
  end
  
  def upload_avatar
    
  end
  
  def crop_banner
    
  end
  
  def create
    
  end
  
  def view
    @profile = User.find(params[:profile_id])
    @events_count = @profile.events.count
    @news_count = @profile.news.count
    @videos_count = @profile.videos.count
    @uploads_count = @profile.uploads.count
    @deals_count = @profile.deals.count
  end
  
  def show
    @profile = User.find(current_user.id)
  end
  
  def update
    if params[:coming_action] == "upload_avatar"
      if @user.update(user_params)
        redirect_to profile_upload_avatar_path(current_user), notice: 'Profile picture updated successfully.' 
      else
        render(:action => "upload_avatar")
      end
    elsif params[:coming_action] == "upload_banner"
      if @user.update(user_params)
        redirect_to profile_crop_banner_path(current_user), notice: 'Profile banner ready to crop.'
      else
        render(:action => "upload_banner")
      end
    else
      if @user.update(user_params)
        redirect_to profile_upload_banner_path(current_user), notice: 'Profile banner updated successfully.'
      else
        render(:action => "crop_banner")
      end
    end
  end

  
  def destroy
    @user.avatar = nil
    @user.save
  end
  
  def user_params
    params.permit(:coming_action)
    params.require(:user).permit(:avatar, :banner_image, :crop_x, :crop_y, :crop_w, :crop_h)
  end
  
  def set_user
    @user = current_user
  end
end
