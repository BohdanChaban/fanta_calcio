require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to belong_to(:tour) }
  it { is_expected.to belong_to(:host) }
  it { is_expected.to belong_to(:guest) }

  it { is_expected.to validate_presence_of(:tour) }
  it { is_expected.to validate_presence_of(:host) }
  it { is_expected.to validate_presence_of(:guest) }
  it { is_expected.to validate_presence_of(:start_time) }

  describe 'model actions' do
    let(:game) { Game.first }

    context '#host_goals' do
      it 'return number of host goals' do
        expect(game.host_goals).to eq(game.result[0].to_i)
      end
    end

    context '#guest_goals' do
      it 'return number of guest goals' do
        expect(game.guest_goals).to eq(game.result[2].to_i)
      end
    end
  end
end
