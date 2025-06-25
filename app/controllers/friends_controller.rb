class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
  end

  def search
    if params[:q].present?
      search_term = "%#{params[:q]}%"
      @results = User.where.not(id: current_user.id)
                    .where("name ILIKE ? OR username ILIKE ?", search_term, search_term)
                    .order(created_at: :desc)
      @suggested_friends = []
    else
      @results = []
      @suggested_friends = User.where.not(id: current_user.id)
                              .where.not(id: current_user.friends.pluck(:id))
                              .order("RANDOM()")
                              .limit(6)
    end
  end

  def create
    friend = User.find(params[:friend_id])
    current_user.friendships.create(friend: friend) unless current_user.friends_with?(friend)
    redirect_back fallback_location: friends_path
  end

  def destroy
    friendship = current_user.friendships.find(params[:id])
    friendship.destroy
    redirect_back fallback_location: friends_path, notice: "Friend removed."
  end
end
