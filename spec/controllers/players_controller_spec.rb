require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  describe 'GET #index' do
    let(:players) { Player.all }

    context 'without position params' do
      before do
        get :index
      end

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('index')
      end

      it 'return all players' do
        expect(assigns(:players)).to eq(players)
      end
    end

    context 'with position params' do
      let(:position) { 'P' }
      let(:gk_players) { Player.where(position: position).order(actual_price: :desc) }

      before do
        get :index, params: { position: position }
      end

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('index')
      end

      it 'return players with preset position' do
        expect(assigns(:players)).to eq(gk_players)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { FactoryBot.create(:user_with_team) }
    let(:player) { Player.last }

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

    context 'with invalid attributes' do
      before do
        sign_in user

        allow_any_instance_of(described_class).to receive(:transfer_valid?).and_return(false)

        patch :update, params: { id: player.id }
      end

      it 'update player team' do
        expect(player.team).to eq(nil)
        expect(player.reload.team).to eq(nil)
      end
    end
  end

  describe 'GET #show' do
    context 'with valid attributes' do
      let(:player) { Player.first }

      before do
        get :show, params: { id: player.id }, format: :json
      end

      it 'response success' do
        expect(response).to be_success
      end

      it 'return player' do
        expect(assigns(:player)).to eq(player)
      end
    end
  end
end
