require 'rails_helper'

RSpec.describe Members::Updater do
  describe '#call' do
    let(:squad) { FactoryBot.create(:squad, team: FactoryBot.create(:user_with_team).team, tour: Tour.last) }
    let(:member) { FactoryBot.create(:member, player: Player.find_by(name: 'SIMEONE'), squad: squad) }

    let(:subject) { described_class.call(member) }

    context 'when member have info' do
      it 'updates member' do
        expect(subject).to eq(true)
      end
    end

    context 'when member have info' do
      before do
        allow_any_instance_of(described_class).to receive(:member_row).and_return(nil)
      end

      it 'does not update member' do
        expect(subject).to eq(nil)
      end
    end
  end
end
