class PlayersController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  before_action :find_team, only: [:update]
  before_action :find_player, only: [:update, :show]

  def index
    @players = if params[:position]
                 Player.where(position: params[:position]).order(actual_price: :desc)
               else
                 Player.all
               end

    respond_to do |format|
      format.html
      format.json { render json: @players }
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

  def show
    respond_to do |format|
      format.html
      format.json { render json: @player }
    end
  end

  private

  def find_player
    @player = Player.find(params[:id])
  end

  def transfer_valid?
    Teams::TransferValidator.call(@team, @player)
  end
end
