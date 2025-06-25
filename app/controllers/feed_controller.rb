class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    @be_reads = BeRead.with_attached_photo.where(posted_on_feed: true).order(created_at: :desc)
  end
end
