class FollowController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
  end
end