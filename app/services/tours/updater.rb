module Tours
  class Updater
    include Builder

    def self.call(number)
      new(number).call
    end

    attr_accessor :number, :tour

    def initialize(number)
      @number = number
      @tour = Tour.find_by(number: number, season: season)
    end

    def call
      update_tour

      update_games
    end

    private

    def update_tour
      tour.update(
        base_date: base_date
      )
    end

    def update_games
      games_css.each do |game_info|
        Games::Updater.call(game_info, tour)
      end
    end
  end
end
