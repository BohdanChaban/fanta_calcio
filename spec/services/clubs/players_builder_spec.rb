require 'rails_helper'

RSpec.describe Clubs::PlayersBuilder do
  describe '#call' do
    let(:club) { Club.first }

    let(:subject) { described_class.call(club) }

    it 'returns array with club players builds' do
      expect(subject).to include(Player)
    end

    it 'returns players name' do
      expect(subject.first.name).not_to eq(nil)
    end

    it 'returns players position' do
      expect(subject.first.position).not_to eq(nil)
    end

    it 'returns players initial price' do
      expect(subject.first.init_price).not_to eq(nil)
    end

    it 'returns players actual price' do
      expect(subject.first.actual_price).not_to eq(nil)
    end

    it 'returns players avatar' do
      expect(subject.first.avatar).not_to eq(nil)
    end

    it 'sets players club' do
      expect(subject.first.club).to eq(club)
    end
  end
end
