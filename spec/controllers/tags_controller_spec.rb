require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  describe 'index' do
    it 'assigns all teams in an instance variable' do
      tags = FactoryBot.create_list(:tag, 3)
      get :index
      expect(assigns(:tags)).to eq(tags)
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
    it 'finds the tag to be shown' do
      tag = FactoryBot.create(:tag)
      get :show, params: {id: tag.id}
      expect(assigns(:tag)).to eq(tag)
    end

    it' renders the show view' do
      tag = FactoryBot.create(:tag)
      get :show, params: {id: tag.id}
      expect(response).to render_template(:show)
    end

    it 'returns 200 status code on success' do
      tag = FactoryBot.create(:tag)
      get :show, params: {id: tag.id}
      expect(response).to have_http_status(200)
    end
  end
end
