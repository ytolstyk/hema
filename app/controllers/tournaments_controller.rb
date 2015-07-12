class TournamentsController < ApplicationController
  before_action :ensure_logged_in, only: [:create, :destroy]

  def show
    @tournament = Tournament.find(params[:id])
    @fighters = @tournament.fighters
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      redirect_to tournaments_show_path(@tournament)
    else
      flash[:errors] = @tournament.errors.full_messages
      redirect_to add_tournament_path(@tournament.event)
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    event_id = @tournament.event_id
    @tournament.destroy
    redirect_to events_show_path(event_id)
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :weapon_type, :event_id, :gender,
                                       :material, :duration, :victory_points)
  end
end
