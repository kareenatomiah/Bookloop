class ApplicationController < ActionController::Base
  # Require users to be logged in by default
  before_action :authenticate_user!

  # Uncomment and implement if you want locale support
  # before_action :set_locale

  # Redirect user after sign in (login)
  def after_sign_in_path_for(resource)
    dashboard_path
  end

  # Redirect user after sign up (registration)
  # Note: This works only if you override Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    dashboard_path
  end

  private

  # Example method to set locale, if needed
  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end
end
