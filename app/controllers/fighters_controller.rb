class FightersController < ApplicationController
  def show
    @fighter = Fighter.find(params[:id])
  end
end
