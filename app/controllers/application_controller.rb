class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) << [:nickname, :fname, :lname, :greek_class, :xseason, :status]
    devise_parameter_sanitizer.for(:account_update) << [:status]
  end

  def after_sign_in_path_for(resource)
  		root_path
  end

  def after_sign_out_path_for(resource)
  		root_path
  end

end
