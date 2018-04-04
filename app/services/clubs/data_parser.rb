module Clubs
  class DataParser
    POINTS_FOR_WIN = 3

    def self.call(name)
      new(name).call
    end

    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def call
      stats = html_page.css('div#statistiche div.sqcard div.row')[0].children

      {
        games: stats[0].children[0].text.to_i,
        win: stats[1].children[0].text.to_i,
        draw: stats[2].children[0].text.to_i,
        lose: stats[3].children[0].text.to_i,
        goals_diff: stats[4].children[0].text.to_i,
        position: stats[5].children[0].text.to_i,
        points: count_points(stats[1].children[0].text.to_i, stats[2].children[0].text.to_i)
      }
    end

    private

    def count_points(win, draw)
      win * POINTS_FOR_WIN + draw
    end

    def url
      "https://www.fantagazzetta.com/squadre/#{name}"
    end

    def html_page
      Nokogiri::HTML(RestClient.get(url))
    end
  end
end
