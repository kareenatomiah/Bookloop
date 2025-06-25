class FeedController < ApplicationController
  def index
    @be_reads = BeRead.where(posted_on_feed: true).order(created_at: :desc)
  end
end
