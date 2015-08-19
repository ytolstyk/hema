class TournamentsController < ApplicationController
  before_action :ensure_logged_in, only: [:create, :destroy, :remove_fighter, :add_fighter, :save_pools]

  def show
    @tournament = Tournament.includes({ pools: :fighters }, { pools: :pool_fighters }, :event).find(params[:id])
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

  def add_rules
    @tournament = Tournament.includes(:scores).find(params[:id])
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

  def add_fighter
    @tournament = Tournament.find(params[:id])
    @pool = @tournament.pools.find_by_name(Pool::DEFAULT_POOL)
    first_name = params[:fighter][:first_name].strip
    last_name = params[:fighter][:last_name].strip
    flash[:notice] = @pool.add_or_create_fighter(params[:id], first_name, last_name)
    redirect_to tournaments_show_path(@tournament)
  end

  def remove_fighter
    @tournament = Tournament.includes({ pools: :fighters }).find(params[:id])
    @pool = @tournament.pools.find(params[:pool_id])
    @pool.remove_fighter(params[:fighter_id])

    fighter = Fighter.find_by_id(params[:fighter_id])
    flash[:notice] = "#{fighter.first_name} #{fighter.last_name} was removed" if fighter

    redirect_to tournaments_show_path(@tournament)
  end

  def save_pools
    @tournament = Tournament.includes(:pools, { pools: :pool_fighters }).find(params[:id])
    success = true
    message = "Pools saved"
    params[:pools].each do |key, pool|
      current_pool = @tournament.pools.find(pool[:id])
      new_pool_fighters = pool[:fighters] || []
      current_pool.update_pool new_pool_fighters
    end

    render json: { success: success, message: message }
  end
  
  private

  def tournament_params
    params.require(:tournament).permit(:name, :weapon_type, :event_id, :gender,
                                       :material, :duration, :victory_points)
  end
end
