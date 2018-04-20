module Tours
  class Creator
    include Builder

    def self.call(number)
      new(number).call
    end

    attr_accessor :number, :tour

    def initialize(number)
      @number = number
    end

    def call
      create_tour

      create_games
    end

    private

    def create_tour
      @tour = Tour.create(
        number: number,
        base_date: base_date,
        season: season
      )
    end

    def create_games
      games_css.each do |game_info|
        Games::Creator.call(game_info, tour)
      end
    end
  end
end
