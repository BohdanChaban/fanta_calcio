class ClubsController < ApplicationController
  before_action :find_club, only: [:show, :fixtures]
  def index
    @clubs = Club.all.order(:position)

    respond_to do |format|
      format.html
      format.json { render json: @clubs }
    end
  end

  def show
    @players = @club.players.order(id: :asc)

    respond_to do |format|
      format.html
      format.json { render json: { club: @club, players: @players } }
    end
  end

  def fixtures
    @games = @club.games.includes(:host, :guest, :tour).order(id: :asc)

    respond_to do |format|
      format.html
      format.json { render json: @club.games, each_serializer: GamesSerializer, adapter: :json }
    end
  end

  private

  def find_club
    @club = Club.find(params[:id])
  end
end
