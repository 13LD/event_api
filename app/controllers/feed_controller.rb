class FeedController < ApplicationController
 before_action :set_user, except: :front
  respond_to :html, :js

  def index
    @events = Event.new
    @invites = @user.all_following.unshift(@user)
    @activities = PublicActivity::Activity.where(owner_id: @invites).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render json: @activities

  end

  def front
    @activities = PublicActivity::Activity.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render json: @activities

  end

  def find_users
    @invites = @user.all_following
    @users =  User.where.not(id: @invites.unshift(@user)).paginate(page: params[:page])
  end

  private
  def set_user
    @user = current_user
  end
end