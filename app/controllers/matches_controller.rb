class MatchesController < ApplicationController
  def show
    @match = Match.includes(:match_info, :exchanges, { pool: :tournament }).find_by_id(params[:id])
  end
end
