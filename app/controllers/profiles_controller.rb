class ProfilesController < ApplicationController
  before_filter :set_user
  before_filter :authenticate_user!, :except => [:view]
  layout 'user'

  protect_from_forgery except: [:jpegcam_upload]
  
  def upload_banner
  end

  def upload_avatar
  end
  
  def jpegcam_upload
    File.open(upload_path, 'wb') do |f|
      f.write request.raw_post
    end
    render :text => "ok"
  end

  def save_avatar
    if (avatar = uploaded_avatar(@user)).present?
      @user.avatar = avatar
      if @user.save
        File.delete avatar.path
        redirect_to root_path, notice: "User Avatar Updated."
      else
        File.delete avatar.path
        redirect_to take_pic_profile_path, notice: "Error Updating User Avatar."
      end
    else
      redirect_to take_pic_profile_path, notice: "Retake Picture."
    end
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
        redirect_to upload_avatar_profile_path(current_user), notice: 'Profile picture updated successfully.' 
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


  def take_pic
    @profile = User.find(params[:id])
  end

  private

    def upload_path # is used in upload and create
      File.join(Rails.root, 'tmp/user/avatar', "avatar_#{@user.id}.jpg")
    end

    def uploaded_avatar(user)
      file_name = "#{Rails.root}/tmp/user/avatar/avatar_#{user.id}.jpg"
      if File.exist?(file_name)
        File.open(file_name)
      else
        nil
      end
    end
end
