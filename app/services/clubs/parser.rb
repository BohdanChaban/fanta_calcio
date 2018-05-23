module Clubs
  class Parser
    POINTS_FOR_WIN = 3

    def self.call(page)
      new(page).call
    end

    attr_accessor :page

    def initialize(page)
      @page = page
    end

    def call
      {
        win: parse_details(1),
        draw: parse_details(2),
        lose: parse_details(3),
        goals_diff: parse_details(4),
        position: parse_details(5),
        points: count_points(parse_details(1), parse_details(2))
      }
    end

    private

    def parse_details(element_number)
      stats[element_number].children[0].text.to_i
    end

    def count_points(win, draw)
      win * POINTS_FOR_WIN + draw
    end

    def stats
      raise "Team is not Found" if team_row.empty?
      @stats ||= team_row[0].children
    end

    def team_row
      @team_row ||= page.css('div#statistiche div.sqcard div.row')
    end
  end
end
