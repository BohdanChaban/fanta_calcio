require 'rails_helper'

RSpec.describe SquadsController, type: :controller do
  let(:user) { FactoryBot.create(:user_with_squad) }

  describe 'GET #index' do
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

      it 'return user squads' do
        expect(assigns(:squads)).to eq(user.team.squads)
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

  describe 'GET #show' do
    let(:squad) { user.team.squads.first }

    context 'with valid attributes' do
      before do
        sign_in user

        get :show, params: { id: squad.id }
      end

      it 'response success' do
        expect(response).to be_success
      end

      it 'return squad' do
        expect(assigns(:squad)).to eq(squad)
      end

      it 'return squad main members' do
        expect(assigns(:main_members)).to eq(squad.members.main)
      end

      it 'return squad reserve members' do
        expect(assigns(:reserve_members)).to eq(squad.members.reserve)
      end
    end

    context 'without authorize user' do
      before do
        sign_in nil

        get :show, params: { id: squad.id }
      end

      it 'redirect to sign in' do
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'GET #new' do
    let(:user) { FactoryBot.create(:user_with_team_and_players) }

    context 'with valid attributes' do
      let(:players) { user.team.players.order(position: :desc) }

      before do
        sign_in user

        get :new
      end

      it 'response success' do
        expect(response).to be_success
        expect(response).to render_template('new')
      end

      it 'response user team players' do
        expect(assigns(:players)).to eq(players)
      end

      it 'response user team gk players' do
        expect(assigns(:gk)).to eq(players.gk)
      end

      it 'response user team df players' do
        expect(assigns(:df)).to eq(players.df)
      end

      it 'response user team mf players' do
        expect(assigns(:mf)).to eq(players.mf)
      end

      it 'response user team fw players' do
        expect(assigns(:fw)).to eq(players.fw)
      end
    end

    context 'without authorize user' do
      before do
        sign_in nil

        get :new
      end

      it 'redirect to sign in' do
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user_with_team_and_players) }
    let(:players) { user.team.players }
    let(:members_ids_hash) {
      {
        id0: players.gk.first,
        id10: players.df[0],
        id11: players.df[1],
        id12: players.df[2],
        id13: players.df[3],
        id20: players.mf[0],
        id21: players.mf[1],
        id22: players.mf[2],
        id30: players.fw[0],
        id31: players.fw[1],
        id32: players.fw[2]
      }
    }
    let(:reserve_ids_hash) {
      {
        id0: players.gk[1],
        id1: players.df[4],
        id2: players.df[5],
        id3: players.mf[3],
        id4: players.mf[4],
        id5: players.fw[3],
        id6: players.fw[4]
      }
    }

    context 'with authorized user' do
      before do
        sign_in user
      end

      context 'with valid attributes' do
        let(:members) { user.team.squads.first.members }

        before do
          allow(Tour).to receive(:next).and_return(Tour.first)

          post :create, params: { members: members_ids_hash, reserve: reserve_ids_hash }
        end

        it 'create new squad' do
          expect(user.team.squads.count).to eq(1)
        end

        it 'create correct number of squad members' do
          expect(members.count).to eq(18)
        end

        it 'create correct number of squad main members' do
          expect(members.main.count).to eq(11)
        end

        it 'create correct number of squad reserve members' do
          expect(members.reserve.count).to eq(7)
        end
      end

      context 'with invalid attributes' do
        let(:subject) { post :create, params: { members: members_ids_hash, reserve: reserve_ids_hash } }

        before do
          allow(Tour).to receive(:next).and_return(nil)

          post :create, params: { members: members_ids_hash, reserve: reserve_ids_hash }
        end

        it 'don`t create new squad' do
          expect(user.team.squads.count).to eq(0)
        end

        it 'redirect to new squad url' do
          expect(subject).to redirect_to('/squads/new')
        end
      end
    end

    context 'without authorize user' do
      before do
        sign_in nil

        post :create, params: { members: members_ids_hash, reserve: reserve_ids_hash }
      end

      it 'redirect to sign in' do
        expect(response.status).to eq(302)
      end
    end
  end

  # TODO: edit, update actions
end
