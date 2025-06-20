class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def update
    if params[:user][:avatar_upload].present?
      uploaded_file = params[:user][:avatar_upload]

      begin
        cloudinary_response = Cloudinary::Uploader.upload(uploaded_file.path)
        params[:user][:avatar_url] = cloudinary_response["secure_url"]
      rescue => e
        flash[:alert] = "Failed to upload avatar image. Please try again."
        redirect_to edit_user_registration_path and return
      end
    end

    params[:user].delete(:avatar_upload)

    if resource.update_without_password(account_update_params)
      set_flash_message!(:notice, :updated_custom)  # <-- Use custom flash key
      redirect_to dashboard_path
    else
      flash.now[:alert] = "Failed to update profile. Please check the form."
      render :edit, status: :unprocessable_entity
    end
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :avatar_upload, :avatar_url, :name, :email,
      :password, :password_confirmation,
      :date_of_birth, :country, :bio
    ])
  end

  # Override Devise method to skip password validation on update
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # Redirect path after update
  def after_update_path_for(resource)
    dashboard_path
  end
end
