require 'rails_helper'

RSpec.describe Club, type: :model do
  it { is_expected.to have_many(:players) }
  it { is_expected.to have_many(:host_games) }
  it { is_expected.to have_many(:guest_games) }

  context 'with valid name provided' do
    let(:club) { described_class.new(name: 'parma') }
    let(:club_params) do
      {
        win: 11,
        draw: 12,
        lose: 13,
        goals_diff: 6,
        position: 21,
        points: 45
      }
    end

    before do
      allow(Clubs::Parser).to receive(:call).with(club.name).and_return(club_params)
      allow(Api::Url).to receive(:club_image).with(club.name).and_return('club_logo_url')
    end

    it 'club is valid' do
      expect(club.valid?).to be true
    end

    it '#update_info' do
      expect(club).to receive(:update_info)
      club.save
    end

    it '#update_logo' do
      expect(club).to receive(:update_logo)
      club.save
    end

    it '#create_players' do
      expect(club).to receive(:create_players)
      club.save
    end
  end

  context 'callbacks' do
    let(:club) { Club.first }

    it 'updates club logo' do
      expect(club.logo).to_not eq(nil)
    end

    it 'updates club params' do
      expect(club.position).to_not eq(nil)
    end

    it 'creates club players' do
      expect(club.players.count).to_not eq(0)
    end
  end

  context 'with blank name provided' do
    let(:club) { described_class.new(name: '') }

    it 'club is invalid' do
      expect(club.valid?).to be false
    end
  end

  context 'with duplicated name provided' do
    let(:club1) { Club.first }
    let(:club2) { described_class.new(name: club1.name) }

    it 'club is invalid' do
      expect(club2.valid?).to be false
    end
  end
end
