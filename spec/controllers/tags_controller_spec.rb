require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  describe 'index' do
    it 'assigns all tags in an instance variable ordered by rca count of each tag' do
      tags = Array.new
      tag1 = FactoryBot.create(:tag)
      tag1.rcas = FactoryBot.create_list(:rca, 3)
      tags << tag1
      tag2 = FactoryBot.create(:tag)
      tag2.rcas = FactoryBot.create_list(:rca, 2)
      tags << tag2
      tag3 = FactoryBot.create(:tag)
      tag3.rcas = FactoryBot.create_list(:rca, 4)
      tags << tag3
      tags = tags.sort{ |tag1 ,tag2| tag2.rcas.count <=> tag1.rcas.count }
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
