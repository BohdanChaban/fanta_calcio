class ClubsController < ApplicationController
  before_action :find_club, only: [:show, :fixtures]
  def index
    @clubs = Club.all.order(:position)
  end

  def show
    @players = @club.players.order(id: :asc)
  end

  def fixtures
    @games = @club.games.includes(:host, :guest, :tour).order(id: :asc)
  end

  private

  def find_club
    @club = Club.find(params[:id])
  end
end
