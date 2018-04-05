require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }

    context 'with valid attributes' do
      it 'create new team' do
        sign_in user

        post :create, params: { team: FactoryBot.attributes_for(:team) }
        expect(Team.count).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it 'don`t create new team' do
        sign_in user

        post :create, params: { team: FactoryBot.attributes_for(:team, name: '') }
        expect(Team.count).to eq(0)
      end
    end

    context 'without authorize user' do
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
      it 'return user team' do
        sign_in user

        get :index

        expect(response).to be_success
        expect(response).to render_template('index')
        expect(assigns(:team)).to eq(user.team)
      end
    end

    context 'without authorize user' do
      it 'redirect to sign in' do
        sign_in nil

        get :index

        expect(response.status).to eq(302)
      end
    end
  end

  # TODO: new
end
