class TournamentsController < ApplicationController
  def show
    @tournament = Tournament.find(params[:id])
    @fighters = @tournament.fighters
  end
end
