class ProfilesController < ApplicationController
  before_filter :set_user
  before_filter :authenticate_user!
  layout 'user'
  def new
    
  end
  
  def create
    
  end
  
  def show
    @profile = User.find(current_user.id)
  end
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to new_profile_path, notice: 'Profile picture updated successfully.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user.avatar = nil
    @user.save
  end
  
  def user_params
    params.require(:user).permit(:avatar)
  end
  
  def set_user
    @user = current_user
  end
end
