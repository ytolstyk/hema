class PoolsController < ApplicationController
  before_action :ensure_logged_in, only: [:create, :destroy]

  def create
    name = "Pool #{Tournament.find(pool_params[:tournament_id]).pools.count + 1}"
    @pool = Pool.create(name: name, tournament_id: pool_params[:tournament_id])
    if !@pool.save
      flash[:errors] = @pool.errors.full_messages
    end

    redirect_to tournament_pools_path(@pool.tournament_id)
  end

  def destroy
    @pool = Pool.find(params[:id])
    if @pool.name == Pool::DEFAULT_POOL
      redirect_to tournament_pools_path(@pool.tournament_id)
      return
    end

    @pool.reassign_fighters Pool::DEFAULT_POOL
    @pool.destroy
    redirect_to tournament_pools_path(@pool.tournament_id)
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :tournament_id)
  end
end
