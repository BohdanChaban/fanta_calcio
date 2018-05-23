require 'rails_helper'

RSpec.describe Clubs::Parser do
  describe '#call' do
    let(:page) { Nokogiri::HTML(File.open(Rails.root.join('spec', 'fixtures', 'clubs', 'milan.html'))) }

    let(:subject) { described_class.call(page) }

    it 'returns hash with club params' do
      expect(subject).to include(:win, :draw, :lose, :goals_diff, :position, :points)
    end
  end
end
