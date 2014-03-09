class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :get_count
  
  layout 'application'
  
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def devise_mapping
    Devise.mappings[:user]
  end

  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end
  
  def get_count
    @no_uploads = Upload.all.size + Content.all.size
    @no_views = View.all.count
    @no_comments = Comment.all.size
    @no_shares = ShareCount.all.count
  end

  helper_method :resource, :resource_name, :devise_mapping

  protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :full_name
     devise_parameter_sanitizer.for(:account_update).concat([:full_name, :home_phone, :mobile_phone, :street, :city, :zip, :state, :country, :occupation, :gender, :words_of_wisdom, :fax, :facebook, :twitter, :google_plus, :twitter, :p_interest, :linked_in])
   end
   
end
