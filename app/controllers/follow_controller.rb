class FollowController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def create
    @event = Event.find(params[:event_id])
    current_user.follow(@event)
    render json: {}, status: :created
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
  end

end