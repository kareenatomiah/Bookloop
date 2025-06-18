class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :splash ]

  def home
  end

  def splash
    redirect_to dashboard_path if user_signed_in?
  end
end
