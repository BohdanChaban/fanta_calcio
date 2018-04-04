module Clubs
  class PlayersCreator
    def self.call(club)
      new(club).call
    end

    attr_accessor :club

    def initialize(club)
      @club = club
    end

    def call
      players = html_page.css('table')[0].children[1].children

      players.each do |player|
        player_info = {
          name: player.children[1].text,
          position: player.children[2].text,
          init_price: player.children[4].text,
          actual_price: player.children[5].text,
          avatar: avatar_url(player.children[1].text),
          club: club
        }

        Player.create(player_info)
      end
    end

    private

    def url
      "https://www.fantagazzetta.com/squadre/#{club.name}"
    end

    def avatar_url(name)
      "https://content.fantagazzetta.com/web/campioncini/card/#{name}.jpg"
    end

    def html_page
      Nokogiri::HTML(RestClient.get(url))
    end
  end
end
