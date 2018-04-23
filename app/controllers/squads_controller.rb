class SquadsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team, only: [:index, :new, :create, :show]
  before_action :find_squad, only: [:edit, :update, :show]

  def index
    @squads = @team.squads
  end

  def show
    @main_members = @squad.members.main.includes(:player).order('players.position desc')
    @reserve_members = @squad.members.reserve.includes(:player).order('players.position desc')
  end

  def new
    @squad = Squad.new
    @players = @team.players.order(position: :desc)
    @gk = @players.gk
    @df = @players.df
    @mf = @players.mf
    @fw = @players.fw
  end

  def create
    @squad = Squad.new(team: @team, tour: Tour.next)

    if @squad.save
      create_members

      redirect_to @squad, notice: 'Squad was successfully created.'
    else
      redirect_to new_squad_path, warning: 'Squad is invalid'
    end
  end

  def edit; end

  def update
    # if @squad.update_attributes(params[:squad])
    #   redirect_to @squad, notice: 'Squad was successfully updated.'
    # else
    #   render action: 'edit'
    # end
  end

  private

  def find_squad
    @squad = Squad.find(params[:id])
  end

  def members_params
    params.require(:members).permit(:id0,
                                    :id10, :id11, :id12, :id13, :id14,
                                    :id20, :id21, :id22, :id23, :id24,
                                    :id30, :id31, :id32)
  end

  def reserve_params
    params.require(:reserve).permit(:id0, :id1, :id2, :id3, :id4, :id5, :id6)
  end

  # TODO: move to service
  def create_member(id, status = 0)
    Member.create(
      squad: @squad,
      player_id: id,
      status: status
    )
  end

  def create_members
    members_params.each do |_key, id|
      create_member(id)
    end

    reserve_params.each do |_key, id|
      create_member(id, 1)
    end
  end
end
