class ProfilesController < ApplicationController
  before_filter :set_user
  before_filter :authenticate_user!
  layout 'user'
  
  def upload_banner
    
  end
  
  def upload_avatar
    
  end
  
  def create
    
  end
  
  def show
    @profile = User.find(current_user.id)
  end
  
  def update
    if params[:coming_from] == "upload_avatar"
      if @user.update(user_params)
        redirect_to profile_upload_avatar_path(current_user), notice: 'Profile picture updated successfully.' 
      else
        render(:action => "upload_avatar")
      end
    else
      if @user.update(user_params)
        redirect_to profile_upload_banner_path(current_user), notice: 'Profile banner updated successfully.'
      else
        render(:action => "upload_banner")
      end
    end
  end

  
  def destroy
    @user.avatar = nil
    @user.save
  end
  
  def user_params
    params.require(:user).permit(:avatar, :banner_image)
  end
  
  def set_user
    @user = current_user
  end
end
