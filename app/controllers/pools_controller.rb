class PoolsController < ApplicationController
  def create
    @pool = Pool.create(pool_params)
    if @pool.save
      redirect_to tournament_pools_path(@pool.tournament_id)
    else
      flash.now[:errors] = @pool.errors.full_messages
      render :new
    end
  end

  def pool_params
    params.require(:pool).permit(:name, :tournament_id)
  end
end
