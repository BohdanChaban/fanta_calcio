require 'rails_helper'

RSpec.describe Games::Updater do
  describe '#call' do
    let(:season) { Season.last }
    let(:tour) { Tour.last }

    let(:game_info) do
      Nokogiri::HTML(RestClient.get(Api::Url.tour(season.years, tour.number))).css('section.risultati div.box-partita').first
    end

    let(:subject) { described_class.call(game_info, tour) }

    it 'updates game' do
      expect(subject).to eq(true)
    end
  end
end
