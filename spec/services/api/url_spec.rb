require 'rails_helper'

RSpec.describe Api::Url do
  describe '#team' do
    let(:name) { 'milan' }

    let(:subject) { described_class.team(name) }

    it 'returns team url to fantagazzetta host' do
      expect(subject).to include('fantagazzetta.com')
    end

    it 'includes club name' do
      expect(subject).to include(name)
    end
  end

  describe '#image' do
    let(:name) { "ANDRE' SILVA" }

    let(:subject) { described_class.image(name) }

    it 'returns player image url to fantagazzetta host' do
      expect(subject).to include('content.fantagazzetta.com')
    end

    it 'normalize player name in url' do
      expect(subject).to_not include("' ")
      expect(subject).to include('ANDRE-SILVA')
    end
  end

  describe '#club_image' do
    let(:name) { 'milan' }

    let(:subject) { described_class.club_image(name) }

    it 'returns club image url to fantagazzetta host' do
      expect(subject).to include('content.fantagazzetta.com')
    end

    it 'includes club name' do
      expect(subject).to include(name)
    end
  end

  describe '#tour' do
    let(:season) { Season.first.years }
    let(:number) { 1 }

    let(:subject) { described_class.tour(season, number) }

    it 'returns tour url to legaseriea host' do
      expect(subject).to include('legaseriea')
    end

    it 'includes season years' do
      expect(subject).to include(season)
    end

    it 'includes tour number' do
      expect(subject).to include(number.to_s)
    end
  end

  describe '#results' do
    let(:subject) { described_class.results }

    it 'returns result url to fantapiu3 host' do
      expect(subject).to include('fantapiu3')
    end
  end
end
