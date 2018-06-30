require 'rails_helper'

RSpec.describe RcasController, type: :controller do
  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  describe 'index' do
    it 'assigns all rcas in an instance variable' do
      rcas = FactoryBot.create_list(:rca, 3)
      get :index
      expect(assigns(:rcas)).to eq(rcas)
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

  describe 'new' do
    it 'creates new object of type Rca' do
      get :new
      expect(assigns(:rca)).to be_an_instance_of(Rca)
    end

    it 'creates new object of type User associated with rca being created' do
      get :new
      expect(assigns(:rca).user).to be_an_instance_of(User)
    end


    it 'assigns all teams in an instance variable' do
      teams = FactoryBot.create_list(:team, 3)
      get :new
      expect(assigns(:teams)).to eq(teams)
    end

    it 'renders the new view' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'returns 200 status code on success' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'create' do
    it 'saves newly created valid rca' do
      expect do
        post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      end.to change(Rca, :count).by(1)
    end

    it 'finds or create valid user' do
      expect do
        post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      end.to change(User, :count).by(1)

      expect do
        post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      end.to change(User, :count).by(0)
    end

    it 'renders the index if rca and user is valid' do
      post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      expect(response).to redirect_to(rcas_path)
    end

    it 'renders the new form if the rca is not valid' do
      post :create, params: { rca: { title: '', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      expect(response).to render_template(:new)
    end

    it 'renders the new form if the user is not valid even if rca is valid' do
      post :create, params: { rca: { title: 'fadfa', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@gmail.com' } }
      expect(response).to render_template(:new)
    end

    it 'associates created user with the created rca' do
      post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      expect(Rca.all.last.user).to eq(User.all.last)
    end

    it 'assigns all teams in a instance variable' do
      teams = FactoryBot.create_list(:team, 3)
      post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      teams << Rca.all.last.team
      expect(assigns(:teams)).to eq(teams)
    end
  end

  describe 'edit' do
    it 'finds the rca to be edited' do
      rca = FactoryBot.create(:rca)
      get :edit, params: { id: rca.id }
      expect(assigns(:rca)).to eq(rca)
    end

    it 'assigns all teams in an instance variable' do
      teams = FactoryBot.create_list(:team, 3)
      rca = FactoryBot.create(:rca)
      teams << rca.team
      get :edit, params: { id: rca.id }
      expect(assigns(:teams)).to eq(teams)
    end

    it 'renders the edit view' do
      rca = FactoryBot.create(:rca)
      get :edit, params: { id: rca.id }
      expect(response).to render_template(:edit)
    end

    it 'returns 200 status code on success' do
      rca = FactoryBot.create(:rca)
      get :edit, params: { id: rca.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'update' do
    it 'finds the rca to be updated' do
      rca = FactoryBot.create(:rca)
      patch :update, params: { id: rca.id, rca: { title: 'fghwaiuf', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" } }
      expect(assigns(:rca)).to eq(rca)
    end

    it 'finds or create valid user' do
      rca = FactoryBot.create(:rca)
      expect do
        patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      end.to change(User, :count).by(1)

      expect do
        patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      end.to change(User, :count).by(0)
    end

    it 'renders the index if rca and user both are valid' do
      rca = FactoryBot.create(:rca)
      patch :update, params: { id: rca.id, rca: { title: 'fghwaiuf', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team, name: 'allocations').id }, user: { email: "abcd@go-jek.com" } }
      expect(response).to redirect_to(rcas_path)
    end

    it 'renders the edit form if the rca is not valid' do
      rca = FactoryBot.create(:rca)
      patch :update, params: { id: rca.id, rca: { title: '', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" } }
      expect(response).to render_template(:edit)
    end

    it 'renders the edit form if user is not valid even if rca is valid' do
      rca = FactoryBot.create(:rca)
      patch :update, params: { id: rca.id, rca: { title: 'abcde', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@yahoo.com" } }
      expect(response).to render_template(:edit)
    end

    it 'assigns all teams in a instance variable' do
      teams = FactoryBot.create_list(:team, 3)
      rca = FactoryBot.create(:rca)
      teams << rca.team
      patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' } }
      teams << Rca.all.last.team
      expect(assigns(:teams)).to eq(teams)
    end
  end

  describe 'destroy' do
    it 'deletes a saved rca' do
      rca = FactoryBot.create(:rca)
      expect { delete :destroy, params: { id: rca.id } }.to change(Rca, :count).by(-1)
    end

    it 'renders the index if rca is deleted' do
      rca = FactoryBot.create(:rca)
      delete :destroy, params: { id: rca.id }
      expect(response).to redirect_to(rcas_path)
    end
  end

  describe 'show' do
    it 'finds the rca to be shown' do
      rca = FactoryBot.create(:rca)
      get :show, params: { id: rca.id }
    end

    it 'renders the show view' do
      rca = FactoryBot.create(:rca)
      get :show, params: { id: rca.id }
      expect(response).to render_template(:show)
    end

    it 'returns 200 status code on success' do
      rca = FactoryBot.create(:rca)
      get :show, params: { id: rca.id }
      expect(response).to have_http_status(200)
    end
  end
end
