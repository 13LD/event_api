class EventsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :update, :destroy]



  # GET /events
  def index
    if params[:interval]
        @events = current_user.events.where(:time => Time.now..Time.now + params[:interval].to_i.day)
    else
        @events = current_user.events
    end
    render json: @events
  end

  # GET /events/1
  def show
    render json: @event.comments
  end

  # POST /events
  def create
    @event = current_user.events.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_users
      @invites = @user.all_following
      @users =  User.where(id: @invites.unshift(@user)).paginate(page: params[:page])
    end
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:name, :when, :place, :purpose, :attachment, :user_id)
    end

    def set_user
      @user = current_user
    end
end
