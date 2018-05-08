require 'rails_helper'

RSpec.describe Games::Creator do
  describe '#call' do
    let(:season) { Season.last }
    let(:tour) { Tour.last }

    let(:game_info) do
      Nokogiri::HTML(RestClient.get(Api::Url.tour(season.years, tour.number))).css('section.risultati div.box-partita').first
    end

    let(:subject) { described_class.call(game_info, tour) }

    it 'creates game' do
      expect(subject).to eq(Game.last)
    end

    it 'sets game tour' do
      expect(subject.tour).to eq(tour)
    end

    it 'sets game host club' do
      expect(subject.host).not_to eq(nil)
    end

    it 'sets game guest club' do
      expect(subject.guest).not_to eq(nil)
    end

    it 'sets game result' do
      expect(subject.result).not_to eq(nil)
    end
  end
end
