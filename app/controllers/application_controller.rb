class ApplicationController < ActionController::Base
  # Require users to be logged in by default
  before_action :authenticate_user!

  # Allow additional parameters for Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirect user after sign in (login)
  def after_sign_in_path_for(resource)
    dashboard_path
  end

  # Redirect user after sign up (registration)
  def after_sign_up_path_for(resource)
    dashboard_path
  end

  protected

  # Permit additional user attributes for sign up and account update
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :avatar_url, :date_of_birth, :country, :bio]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
