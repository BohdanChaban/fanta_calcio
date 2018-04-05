module Clubs
  class PlayersBuilder
    def self.call(club)
      new(club).call
    end

    attr_accessor :club

    def initialize(club)
      @club = club
    end

    def call
      players_css.each_with_object([]) do |player, memo|
        player_info = {
          name: parse_text(player, 1),
          position: parse_text(player, 2),
          init_price: parse_text(player, 4),
          actual_price: parse_text(player, 5),
          avatar: avatar_url(parse_text(player, 1)),
          club: club
        }

        memo << Player.new(player_info)
        memo
      end
    end

    private

    def players_css
      @players_css ||= html_page.css('table')[0].children[1].children
    end

    def parse_text(player, element_number)
      player.children[element_number].text
    end

    def avatar_url(name)
      Api::Url.image(name)
    end

    def html_page
      Nokogiri::HTML(
        RestClient.get(
          Api::Url.team(club.name)
        )
      )
    end
  end
end
