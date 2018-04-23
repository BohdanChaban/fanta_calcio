require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }

    context 'with authorized user' do
      before { sign_in user }

      context 'with valid attributes' do
        it 'create new team' do
          post :create, params: { team: FactoryBot.attributes_for(:team) }
          expect(Team.count).to eq(1)
        end
      end

      context 'with invalid attributes' do
        it 'don`t create new team' do
          post :create, params: { team: FactoryBot.attributes_for(:team, name: '') }
          expect(Team.count).to eq(0)
        end
      end
    end

    context 'without authorized user' do
      it 'don`t create new team' do
        sign_in nil

        post :create, params: { team: FactoryBot.attributes_for(:team) }
        expect(Team.count).to eq(0)
      end
    end
  end

  describe 'GET #index' do
    let(:user) { FactoryBot.create(:user_with_team) }

    context 'with valid attributes' do
      before do
        sign_in user

        get :index
      end

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('index')
      end

      it 'return user team' do
        expect(assigns(:team)).to eq(user.team)
      end
    end

    context 'without authorize user' do
      before do
        sign_in nil

        get :index
      end
      it 'redirect to sign in' do
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'GET #new' do
    before do
      sign_in user
    end

    context 'with valid attributes' do
      let(:user) { FactoryBot.create(:user) }

      before { get :new }

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('new')
      end
    end

    context 'when user already have team' do
      let(:user) { FactoryBot.create(:user_with_team) }
      let(:subject) { get :new }

      it 'redirect to teams path' do
        expect(subject).to redirect_to('/teams')
      end
    end
  end
end
