module Games
  class Updater
    include Builder

    def self.call(game_info, tour)
      new(game_info, tour).call
    end

    attr_accessor :game_info, :game

    def initialize(game_info, tour)
      @game_info = game_info
      @game = tour.games.find_by(host: host)
    end

    def call
      game.update(
        result: result,
        start_time: start_time
      )
    end
  end
end
