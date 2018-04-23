module Tours
  module Builder
    def games_css
      @games_css ||= html_page.css('section.risultati div.box-partita')
    end

    def base_date
      date_str = html_page.css('section.risultati h3').text.match(/(\d{2}\/\d{2}\/\d{4})/)[0]
      Date.strptime(date_str, '%d/%m/%Y')
    end

    def html_page
      Nokogiri::HTML(
        RestClient.get(
          Api::Url.tour(season.years, number)
        )
      )
    end

    def season
      @season ||= Season.last
    end
  end
end
