class MatchesController < ApplicationController
  def show
    @match = Match.includes(pool: :tournament).find_by_id(params[:id])
  end
end
