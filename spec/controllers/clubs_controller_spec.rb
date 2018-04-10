require 'rails_helper'

RSpec.describe ClubsController, type: :controller do
  describe 'GET #index' do
    context 'with valid attributes' do
      let(:club_names) { %w[milan inter roma] }
      let(:all_clubs) do
        club_names.each do |name|
          FactoryBot.create(:club, name: name)
        end
        Club.all.order(:position)
      end

      before do
        get :index
      end

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('index')
      end

      it 'return all clubs' do
        expect(assigns(:clubs)).to eq(all_clubs)
      end
    end
  end

  describe 'GET #show' do
    context 'with valid attributes' do
      let(:club) { FactoryBot.create(:club) }

      before do
        get :show, params: { id: club.id }
      end

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('show')
      end

      it 'return club' do
        expect(assigns(:club)).to eq(club)
      end

      it 'return club players' do
        expect(assigns(:players)).to eq(club.players)
      end
    end
  end

  describe 'GET #fixtures' do
    context 'with valid attributes' do
      let(:club) { FactoryBot.create(:club_with_games) }

      before do
        get :fixtures, params: { id: club.id }
      end

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('fixtures')
      end

      it 'return club' do
        expect(assigns(:club)).to eq(club)
      end

      it 'return club games' do
        expect(assigns(:games)).to eq(club.games)
      end
    end
  end
end
