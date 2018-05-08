require 'rails_helper'

RSpec.describe Squads::Updater do
  describe '#call' do
    let(:user) { FactoryBot.create(:user_with_squad) }
    let(:squad) { user.team.squads.last }

    let(:subject) { described_class.call(squad) }

    it 'updates squad' do
      expect(subject).to eq(true)

      expect(squad.reload.total_score).not_to eq(0)
    end

    it 'updates members appearances' do
      expect(squad.reload.members.played).not_to eq(nil)
    end
  end
end
