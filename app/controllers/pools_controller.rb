class PoolsController < ApplicationController
  before_action :ensure_logged_in, only: [:create, :destroy]

  def create
    @pool = Pool.new(name: 'New pool', tournament_id: pool_params[:tournament_id])
    @pool.name_pool Tournament.find(pool_params[:tournament_id]).pools.count

    flash[:errors] = @pool.errors.full_messages if !@pool.save

    redirect_to tournament_pools_path(@pool.tournament_id)
  end

  def destroy
    @pool = Pool.find(params[:id])
    if @pool.name == Pool::DEFAULT_POOL
      redirect_to tournament_pools_path(@pool.tournament_id)
      return
    end

    @pool.remove_pool
    redirect_to tournament_pools_path(@pool.tournament_id)
  end

  def pool_matches
    @pool = Pool.includes(:matches, { matches: :fighters }).find(params[:id])
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :tournament_id)
  end
end
