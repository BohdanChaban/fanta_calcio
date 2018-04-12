class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def find_team
    @team = current_user.team
    redirect_to new_team_path unless @team
  end
end
