class ExchangesController < ApplicationController
  def new
    @match = Match.includes(pool: :tournament).find_by_id(params[:match_id])
    @exchange = @match.exchanges.new
  end

  def create
    @match = Match.includes(pool: :tournament).find_by_id(params[:match_id])
    @exchange = @match.exchanges.new(exchange_params)

    if @exchange.save # and match ended
      redirect_to exchanges_new_path params[:match_id]
    else
      flash.now[:errors] = @exchange.errors.full_messages
      render :new
    end
  end

  def show
    @exchange = Exchange.includes(match: :match_fighters).find_by_id(params[:id])
  end

  private

  def exchange_params
    params.require(:exchange).permit(:target, :afterblow, :double_hit, :penalty, :fighter_id)
  end
end
