class ApplicationController < ActionController::Base
  
  #protect_from_forgery with: :exception
  before_action :authenticate_v1_user!
  before_action :permitted_parameters, if: :devise_controller?
  respond_to :json
  
  #rescue_from CanCan::AccessDenied do |exception|
  #  redirect_to root_url, alert: exception.message
  #end
  protected

  def permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :city, { images_attributes: [:name] }])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :city])
  end
end
