module Games
  class Builder
    def self.call(game, tour_number)
      new(game, tour_number).call
    end

    attr_accessor :game, :tour_number

    def initialize(game, tour_number)
      @game = game
      @tour_number = tour_number
    end

    def call
      Game.create(game_params)
    end

    private

    def game_params
      {
        tour: Tour.find_by(number: tour_number),
        host: Club.find_by(name: host_club_name),
        guest: Club.find_by(name: guest_club_name),
        start_time: game_time
      }
    end

    def game_time
      start_time = game.children[1].children[1].children[1].text
      DateTime.strptime(start_time, '%d/%m/%Y %H:%M')
    end

    def host_club_name
      club_name(3)
    end

    def guest_club_name
      club_name(5)
    end

    def club_name(element)
      name = game.children[element].children[7].text.downcase

      case name
      when 'chievoverona'
        'chievo'
      when 'hellas verona'
        'verona'
      else
        name
      end
    end
  end
end
