require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'render index view' do
      get :index

      expect(response).to be_success
      expect(response).to render_template('index')
    end
  end
end
