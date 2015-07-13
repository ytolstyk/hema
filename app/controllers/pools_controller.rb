class PoolsController < ApplicationController
  def create
    name = "Pool #{Tournament.find(pool_params[:tournament_id]).pools.count + 1}"
    @pool = Pool.create(name: name, tournament_id: pool_params[:tournament_id])
    if @pool.save
      redirect_to tournament_pools_path(@pool.tournament_id)
    else
      flash.now[:errors] = @pool.errors.full_messages
      render :new
    end
  end

  def destroy
    @pool = Pool.find(params[:id])
    if @pool.name == 'Unassigned'
      return
    end
    @pool.reassign_fighters 'Unassigned'
    @pool.destroy
    redirect_to tournament_pools_path(@pool.tournament_id)
  end

  def pool_params
    params.require(:pool).permit(:name, :tournament_id)
  end
end
