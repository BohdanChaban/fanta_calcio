module Api
  class Url
    HOST = "https://www.fantagazzetta.com"
    CONTENT_HOST = "https://content.fantagazzetta.com"

    def self.team(name)
      "#{HOST}/squadre/#{name}"
    end

    def self.image(name)
      "#{CONTENT_HOST}/web/campioncini/card/#{name}.jpg"
    end

    def self.club_image(name)
      "#{CONTENT_HOST}/web/img/team/#{name}.png"
    end
  end
end
