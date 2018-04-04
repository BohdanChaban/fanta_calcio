class ClubsController < ApplicationController
  def index
    @clubs = Club.all.order(:position)
  end

  def show
    @club = Club.find(params[:id])
    @players = @club.players
  end
end
