module Games
  class Creator
    include Builder

    def self.call(game_info, tour)
      new(game_info, tour).call
    end

    attr_accessor :game_info, :tour

    def initialize(game_info, tour)
      @game_info = game_info
      @tour_number = tour
    end

    def call
      Game.create(
        tour: tour,
        host: host,
        guest: guest,
        start_time: start_time
      )
    end
  end
end
