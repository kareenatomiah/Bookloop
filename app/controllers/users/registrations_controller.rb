class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def update
    if params[:user][:avatar_upload].present?
      resource.avatar.purge if resource.avatar.attached?
      resource.avatar.attach(params[:user][:avatar_upload])
    end

    if resource.update_without_password(account_update_params.except(:avatar_upload))
      set_flash_message!(:notice, :updated)
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = "Failed to update profile. Please check the form."
      render :edit, status: :unprocessable_entity
    end
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :avatar_upload, :name, :email,
      :password, :password_confirmation,
      :date_of_birth, :country, :bio
    ])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
