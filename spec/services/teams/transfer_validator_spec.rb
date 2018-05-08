require 'rails_helper'

RSpec.describe Teams::TransferValidator do
  describe '#call' do
    let(:team) { user.team }
    let(:player) { Player.last }

    let(:subject) { described_class.call(team, player) }

    context 'when team have free place for player position' do
      let(:user) { FactoryBot.create(:user_with_team) }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when team do not have any free places' do
      let(:user) { FactoryBot.create(:user_with_team_and_players) }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'when team do not have any free places for goalkeepers' do
      # TODO
    end

    context 'when team do not have any free places for defenders' do
      # TODO
    end

    context 'when team do not have any free places for midfielders' do
      # TODO
    end

    context 'when team do not have any free places for forwards' do
      # TODO
    end
  end
end
