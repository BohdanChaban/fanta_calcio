require 'rails_helper'

RSpec.describe Member, type: :model do
  it { is_expected.to belong_to(:squad) }
  it { is_expected.to belong_to(:player) }

  it { is_expected.to validate_presence_of(:squad_id) }
  it { is_expected.to validate_presence_of(:player_id) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:appearance) }
  it { is_expected.to validate_presence_of(:total_score) }
  it { is_expected.to validate_presence_of(:points) }
  it { is_expected.to validate_presence_of(:scored_goals) }
  it { is_expected.to validate_presence_of(:scored_penalties) }
  it { is_expected.to validate_presence_of(:conceded_goals) }
  it { is_expected.to validate_presence_of(:missed_penalties) }
  it { is_expected.to validate_presence_of(:assists) }
  it { is_expected.to validate_presence_of(:clean_sheets) }
  it { is_expected.to validate_presence_of(:yellow_cards) }
  it { is_expected.to validate_presence_of(:red_cards) }
  it { is_expected.to validate_presence_of(:own_goals) }

  describe 'model actions' do
    let(:user) { FactoryBot.create(:user_with_team) }
    let(:tour) { Tour.first }
    let(:squad) { FactoryBot.create(:squad, team: user.team, tour: tour) }
    let(:game) { Game.first }
    let(:player_host) { game.host.players.last }
    let(:member_host) { FactoryBot.create(:member, player: player_host, squad: squad) }
    let(:player_guest) { game.guest.players.last }
    let(:member_guest) { FactoryBot.create(:member, player: player_guest, squad: squad) }

    before do
      allow(game).to receive(:result).and_return('3-0')
    end

    context '#game' do
      it 'return member club game in current tour' do
        expect(member_host.game).to eq(member_host.club.games.find_by(tour: tour))
      end
    end

    context '#club_clean_sheet' do
      context 'when club clean sheet' do
        it 'return true' do
          expect(member_host.club_clean_sheet).to eq(true)
        end
      end

      context 'when club conceded goal' do
        it 'return false' do
          expect(member_guest.club_clean_sheet).to eq(false)
        end
      end
    end

    context '#clean_sheet?' do
      let(:member) { FactoryBot.create(:member, player: player, squad: squad) }

      context 'when club clean sheet' do
        context 'when player position P or D' do
          let(:player) { game.host.players.where(position: 'P').last }

          it 'return true' do
            expect(member.clean_sheet?).to eq(true)
          end
        end

        context 'when player position C or A' do
          let(:player) { game.host.players.where(position: 'A').last }

          it 'return false' do
            expect(member.clean_sheet?).to eq(false)
          end
        end
      end

      context 'when club conceded goal' do
        context 'when player position P or D' do
          let(:player) { game.guest.players.where(position: 'P').last }

          it 'return false' do
            expect(member.clean_sheet?).to eq(false)
          end
        end

        context 'when player position C or A' do
          let(:player) { game.guest.players.where(position: 'A').last }

          it 'return false' do
            expect(member.clean_sheet?).to eq(false)
          end
        end
      end
    end
  end
end
