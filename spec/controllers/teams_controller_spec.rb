require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  describe 'index' do
    it 'assigns all teams in an instance variable' do
      teams = FactoryBot.create_list(:team, 3)
      get :index
      expect(assigns(:teams)).to eq(teams)
    end

    it 'renders the index view' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'returns 200 status code on success' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'show' do
    it 'finds the team to be shown' do
      team = FactoryBot.create(:team)
      get :show, params: {id: team.id}
      expect(assigns(:team)).to eq(team)
    end

    it' renders the show view' do
      team = FactoryBot.create(:team)
      get :show, params: {id: team.id}
      expect(response).to render_template(:show)
    end

    it 'returns 200 status code on success' do
      team = FactoryBot.create(:team)
      get :show, params: {id: team.id}
      expect(response).to have_http_status(200)
    end
  end
end
