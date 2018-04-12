class PlayersController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  before_action :find_team, only: [:update]
  before_action :find_player, only: [:update]

  def index
    if params[:position]
      @players = Player.where(position: params[:position]).order(actual_price: :desc)
    else
      @players = Player.all
    end
  end

  def update
    if transfer_valid?
      @player.update(team: @team)
      flash[:success] = "Player #{@player.name} is successfully added to #{@team.name} team"
    else
      flash[:error] = "Player #{@player.name} can not be added to #{@team.name} team"
    end
    redirect_back fallback_location: teams_path
  end

  private

  def find_player
    @player = Player.find(params[:id])
  end

  def transfer_valid?
    Teams::TransferValidator.call(@team, @player)
  end
end
