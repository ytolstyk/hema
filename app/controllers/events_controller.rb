class EventsController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :destroy, :add_tournament]

  def index 
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @tournaments = @event.tournaments
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_index_path
    else
      flash.now[:errors] = @event.errors.full_messages
      render :new
    end
  end

  def add_tournament
    @event = Event.find(params[:id])
    @tournament = @event.tournaments.new
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_index_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :date, :organizer)
  end
end
