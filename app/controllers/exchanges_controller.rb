class ExchangesController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create]

  def new
    @match = Match.includes(pool: :tournament).find_by_id(params[:match_id])
    @exchange = @match.exchanges.new
  end

  def create
    @match = Match.includes(pool: :tournament).find_by_id(params[:match_id])
    @exchange = @match.exchanges.new(exchange_params)

    if @exchange.save
      @match.update_match_info
      redirect to matches_show_path @match.id if @match.completed?
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
    params.require(:exchange).permit(:target, :afterblow, :double_hit, :seconds, :penalty, :fighter_id)
  end
end
