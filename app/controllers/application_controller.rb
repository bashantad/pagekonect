class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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

  helper_method :resource, :resource_name, :devise_mapping

  protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :full_name
     devise_parameter_sanitizer.for(:account_update).concat([:full_name, :phone, :street, :city, :zip, :state, :country])
   end
   
end
