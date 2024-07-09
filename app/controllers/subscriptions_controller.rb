class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to users_path
  end

  def destroy
    user = Subscription.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to users_path
  end
end
