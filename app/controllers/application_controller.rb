class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    profile_path(resource.nickname)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :lastname, :nickname, :age])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :lastname, :nickname, :age])
  end
end