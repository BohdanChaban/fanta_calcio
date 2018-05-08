require 'rails_helper'

RSpec.describe Clubs::Parser do
  describe '#call' do
    let(:name) { 'milan' }

    let(:subject) { described_class.call(name) }

    it 'returns hash with club params' do
      expect(subject).to include(:win, :draw, :lose, :goals_diff, :position, :points)
    end
  end
end
