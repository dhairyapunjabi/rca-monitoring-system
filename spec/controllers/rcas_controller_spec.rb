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

  describe "new" do
    it "creates new object of type Rca" do
      get :new
      expect(assigns(:rca)).to be_an_instance_of(Rca)
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template(:new)
    end

    it "returns 200 status code on success" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "create" do
    it "saves newly created valid rca" do
      expect do
        post :create , params: { rca: { title: 'First rca', description: 'this is my first rca', users: "dada", status: 'Completed', team_id: 2}}
      end.to change(Rca, :count).by(1)
    end

    it "renders the index if rca is valid" do
      post :create , params: { rca: { title: 'First rca', description: 'this is my first rca', users: "dada", status: 'Completed', team_id: 2}}
      expect(response).to redirect_to(rcas_path)
    end

    it "renders the new form if the rca is not valid" do
      post :create , params: { rca: { title: '', description: 'this is my first rca', users: "dasda", status: 'Completed', team_id: 2}}
      expect(response).to render_template(:new)
    end
  end

  describe "edit" do
    it "allows editing of saved rcas" do
      rca = FactoryBot.create(:rca)
      get :edit , params: { id: rca.id}
      expect(assigns(:rca)).to eq(rca)
    end

    it "renders the edit view" do
      rca = FactoryBot.create(:rca)
      get :edit , params: { id: rca.id}
      expect(response).to render_template(:edit)
    end

    it "returns 200 status code on success" do
      rca = FactoryBot.create(:rca)
      get :edit , params: { id: rca.id}
      expect(response).to have_http_status(200)
    end
  end
end
