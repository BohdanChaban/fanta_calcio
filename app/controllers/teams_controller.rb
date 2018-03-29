class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = current_user.team
  end

  def new
    redirect_to teams_path if current_user.team

    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user

    if @team.save
      redirect_to teams_path
    else
      render 'new'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
