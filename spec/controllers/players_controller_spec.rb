require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  describe 'GET #index' do
    let(:club) { FactoryBot.create(:club) }

    context 'with valid attributes' do
      before do
        get :index
      end

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('index')
      end

      it 'return all players' do
        expect(assigns(:players)).to eq(club.players)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { FactoryBot.create(:user_with_team) }
    let(:club) { FactoryBot.create(:club) }
    let(:player) { club.players.last }

    context 'with valid attributes' do
      before do
        sign_in user

        patch :update, params: { id: player.id }
      end

      it 'add player to user team' do
        expect(user.team.players).to include(player)
      end

      it 'update player team' do
        expect(player.team).to eq(nil)
        expect(player.reload.team).to eq(user.team)
      end
    end
  end

  # TODO: show action
end
