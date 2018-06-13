require 'rails_helper'

RSpec.describe RcasController, type: :controller do
  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  describe "index" do
    it "assigns all rcas in an instance variable" do
      rcas=FactoryBot.create_list(:rca, 3)
      get :index
      expect(assigns(:rcas)).to eq(rcas)
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end

    it "returns 200 status code on success" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

end
