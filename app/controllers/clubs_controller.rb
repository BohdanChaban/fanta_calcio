class ClubsController < ApplicationController
  def index
    @clubs = Club.all.order(:position)
  end
end
