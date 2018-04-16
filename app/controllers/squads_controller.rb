class SquadsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team, only: [:new, :create, :show]

  def index
    @squads = @team.squads
  end

  def show
    @squad = Squad.find(params[:id])
  end

  def new
    @squad = Squad.new
    @players = @team.players
    @gk = @team.players.gk
    @df = @team.players.df
    @mf = @team.players.mf
    @fw = @team.players.fw
  end

  def create
    @squad = Squad.new(team: @team, tour: Tour.last)

    if @squad.save
      create_members

      redirect_to @squad, notice: 'Squad was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @squad = Squad.find(params[:id])
  end

  def update
    @squad = Squad.find(params[:id])

    if @squad.update_attributes(params[:squad])
      redirect_to @squad, notice: 'Squad was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

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
  def create_member(id)
    Member.create(
      squad: @squad,
      player_id: id
    )
  end

  def create_members
    members_params.each do |_key, id|
      create_member(id)
    end

    reserve_params.each do |_key, id|
      create_member(id)
    end
  end
end
