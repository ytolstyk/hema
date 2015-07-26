class TournamentsController < ApplicationController
  before_action :ensure_logged_in, only: [:create, :destroy, :remove_fighter, :add_fighter, :tournament_pools]

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

  def tournament_pools
    @tournament = Tournament.includes(:fighters, :pools, { pools: :fighters }).find(params[:id])
  end

  def add_rules
    @tournament = Tournament.find(params[:id])
    @scores = @tournament.scores
  end

  def create_scores
    success = true
    @tournament = Tournament.find(params[:id])

    if params['scores']
      @tournament.scores.delete_all
    else
      success = false
      message = "You must have at least one rule."
    end

    params['scores'].each do |index, score|
      new_score = @tournament.scores.new(target: score['target'], points: score['points'])
      if !new_score.save
        success = false
        message = "Couldn't save the rule #{score['target']}: #{score['points']}"
        break
      end
    end

    render json: { success: success, message: message }
  end

  def show_fighters
    @tournament = Tournament.find(params[:id])
    @fighters = @tournament.fighters
  end

  def add_fighter
    @tournament = Tournament.find(params[:id])
    first_name = params[:fighter][:first_name].strip
    last_name = params[:fighter][:last_name].strip
    flash[:notice] = @tournament.add_or_create_fighter(first_name, last_name)
    redirect_to tournament_fighters_path(@tournament)
  end

  def remove_fighter
    @tournament = Tournament.find(params[:id])
    tournament_fighter = @tournament.tournament_fighters.find_by_fighter_id(params[:fighter_id])
    tournament_fighter.destroy

    fighter = Fighter.find_by_id(params[:fighter_id])
    flash[:notice] = "#{fighter.first_name} #{fighter.last_name} was removed" if fighter

    redirect_to tournament_fighters_path(@tournament)
  end
  
  private

  def tournament_params
    params.require(:tournament).permit(:name, :weapon_type, :event_id, :gender,
                                       :material, :duration, :victory_points)
  end
end
