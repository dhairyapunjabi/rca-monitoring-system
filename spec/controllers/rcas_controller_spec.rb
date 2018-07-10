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
    context 'when all validations are passed' do
      it 'should save newly created valid rca' do
        expect do
          post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(Rca, :count).by(1)
      end

      it 'should find or create valid user' do
        expect do
          post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(User, :count).by(1)

        expect do
          post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(User, :count).by(0)
      end

      it 'should save all action items' do
        expect do
          post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(Actionitem, :count).by(2)
      end

      it 'should find or create valid tag' do
        expect do
          post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, C, Clojure"} }
        end.to change(Tag, :count).by(3)

        expect do
          post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(Tag, :count).by(2)
      end

      it 'should render the index template' do
        post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        expect(response).to redirect_to(rcas_path)
      end
    end

    context 'when any action item is invalid' do
      it "shouldn't create RCA" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'adaed', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(Rca, :count).by(0)
      end

      it "shouldn't create any action item" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'daedaed', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(Actionitem, :count).by(0)
      end

      it "doesn't create User" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'adaed', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(User, :count).by(0)
      end

      it "shouldn't create any tag" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'daedaed', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(Tag, :count).by(0)
      end

      it 'should render the new form' do
        post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        expect(response).to render_template(:new)
      end
    end

    context 'when any tag is invalid' do
      it "shouldn't create RCA" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'adaed', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: " , CSS, Java"} }
        end.to change(Rca, :count).by(0)
      end

      it "shouldn't create any action item" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'daedaed', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: " , CSS, Java"} }
        end.to change(Actionitem, :count).by(0)
      end

      it "shouldn't create any tag" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'daedaed', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: " , CSS, Java"} }
        end.to change(Tag, :count).by(0)
      end

      it "doesn't create User" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'adaed', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: " , CSS, Java"} }
        end.to change(User, :count).by(0)
      end

      it 'should render the new form' do
        post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: " , CSS, Java"} }
        expect(response).to render_template(:new)
      end
    end

    context 'when rca is not valid' do
      it "doesn't create RCA" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: '', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(Rca, :count).by(0)
      end

      it "shouldn't create any action" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: '', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(Actionitem, :count).by(0)
      end

      it "doesn't create User" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: '', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(User, :count).by(0)
      end

      it 'should render the new form' do
        post :create, params: { rca: { title: '', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        expect(response).to render_template(:new)
      end

      it "shouldn't create any tag" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: '', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(Tag, :count).by(0)
      end
    end

    context 'when user is not valid' do
      it "shouldn't create User" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'ikbea', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jk.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(User, :count).by(0)
      end

      it "shouldn't create any Action item" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'ikbea', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jk.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(Actionitem, :count).by(0)
      end

      it "shouldn't create Rca" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'ikbea', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@go-jk.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        end.to change(Rca, :count).by(0)
      end

      it 'should render the new form' do
        post :create, params: { rca: { title: 'fadfa', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@gmail.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
        expect(response).to render_template(:new)
      end

      it "shouldn't create any tag" do
        rca = FactoryBot.create(:rca)
        expect do
          post :create, params: { id: rca.id, rca: { title: 'daedaed', description: 'vacb', status: 'ty', team_id: FactoryBot.create(:team).id }, user: { email: "abcd@gmail.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(Tag, :count).by(0)
      end
    end

    it 'associates created user with the created rca' do
      post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
      expect(Rca.all.last.user).to eq(User.all.last)
    end

    it 'associates created action items with the created rca' do
      post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
      expect(Actionitem.all.to_a.last(2)).to eq(Rca.all.last.actionitems)
    end

    it 'associates created tags with the created rca' do
      post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
      expect(Tag.all.to_a.last(3)).to eq(Rca.all.last.tags)
    end

    it 'assigns all teams in a instance variable' do
      teams = FactoryBot.create_list(:team, 3)
      post :create, params: { rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "" } }
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
      rca.actionitems << FactoryBot.create(:actionitem)
      tag = FactoryBot.create(:tag)
      rca.tags << tag
      patch :update, params: { id: rca.id, rca: { title: 'fghwaiuf', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
      expect(assigns(:rca)).to eq(rca)
    end

    context 'when all validations are passed' do
      it 'should find or create valid user and update the user of the current rca' do
        rca = FactoryBot.create(:rca)
        rca.actionitems << FactoryBot.create(:actionitem)
        tag = FactoryBot.create(:tag)
        rca.tags << tag
        expect do
          patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(User, :count).by(1)

        expect do
          patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(User, :count).by(0)

        expect(Rca.find(rca.id).user.email).to eq('abcd@go-jek.com')
      end

      it 'should create new action items and associate them with the rca' do
        rca = FactoryBot.create(:rca)
        rca.actionitems << FactoryBot.create(:actionitem)
        tag = FactoryBot.create(:tag)
        rca.tags << tag
        expect do
          patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(Actionitem, :count).by(1)

        actionitemslist = Array.new
        actionitemslist << Actionitem.find_by(name: 'root cause')
        actionitemslist << Actionitem.find_by(name: 'segmentation fault')
        expect(Rca.find(rca.id).actionitems).to eq(actionitemslist)
      end

      it 'should remove the old action items from the database' do
        rca = FactoryBot.create(:rca)
        actionitem = FactoryBot.create(:actionitem)
        rca.actionitems << actionitem
        tag = FactoryBot.create(:tag)
        rca.tags << tag
        patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        expect(Actionitem.all.to_a.include?(actionitem)).to eq(false)
      end

      it 'should associate the new tags to the rca while finding/creating them and associate the rca to the updated tags' do
        rca = FactoryBot.create(:rca)
        rca.actionitems << FactoryBot.create(:actionitem)
        tag1 = FactoryBot.create(:tag)
        rca.tags << tag1
        tag2 = FactoryBot.create(:tag, name: 'html')
        rca.tags << tag2
        expect do
          patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(Tag, :count).by(2)

        taglist = Array.new
        taglist << Tag.find_by(name: 'ruby')
        taglist << Tag.find_by(name: 'css')
        taglist << Tag.find_by(name: 'java')
        expect(Rca.find_by(id: rca.id).tags).to eq(taglist)

        expect(Tag.find_by(name: 'ruby').rca_ids.include?(rca.id)).to eq(true)
        expect(Tag.find_by(name: 'java').rca_ids.include?(rca.id)).to eq(true)
        expect(Tag.find_by(name: 'css').rca_ids.include?(rca.id)).to eq(true)
      end

      it 'should not delete the existing tags from the tags database if any tag is removed from the rca even while removing the association between the tag and the rca' do
        rca = FactoryBot.create(:rca)
        rca.actionitems << FactoryBot.create(:actionitem)
        tag1 = FactoryBot.create(:tag)
        rca.tags << tag1
        tag2 = FactoryBot.create(:tag, name: 'html')
        rca.tags << tag2
        expect do
          patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java"} }
        end.to change(Tag, :count).by(2)

        expect(Rca.find_by(id: rca.id).tags.include?(tag2.id)).to eq(false)
        expect(Tag.find_by(id: tag2.id)).to eq(tag2)
        expect(Tag.find_by(id: tag2.id).rca_ids.include?(rca.id)).to eq(false)
      end

      it 'should render the index' do
        rca = FactoryBot.create(:rca)
        rca.actionitems << FactoryBot.create(:actionitem)
        tag = FactoryBot.create(:tag)
        rca.tags << tag
        patch :update, params: { id: rca.id, rca: { title: 'fghwaiuf', description: 'vacb', status: 'Completed', team_id: FactoryBot.create(:team, name: 'allocations').id }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java" } }
        expect(response).to redirect_to(rcas_path)
      end
    end

    it 'renders the edit form if any action item is not valid' do
      rca = FactoryBot.create(:rca)
      rca.actionitems << FactoryBot.create(:actionitem)
      tag = FactoryBot.create(:tag)
      rca.tags << tag
      patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java" } }
      expect(response).to render_template(:edit)
    end

    it 'renders the edit form if the rca is not valid' do
      rca = FactoryBot.create(:rca)
      rca.actionitems << FactoryBot.create(:actionitem)
      tag = FactoryBot.create(:tag)
      rca.tags << tag
      patch :update, params: { id: rca.id, rca: { title: '', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@go-jek.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Java, C++" } }
      expect(response).to render_template(:edit)
    end

    it 'renders the edit form if user is not valid' do
      rca = FactoryBot.create(:rca)
      rca.actionitems << FactoryBot.create(:actionitem)
      tag = FactoryBot.create(:tag)
      rca.tags << tag
      patch :update, params: { id: rca.id, rca: { title: 'abcde', description: 'vacb', status: 'ty', team_id: 321 }, user: { email: "abcd@yahoo.com" }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, Css" } }
      expect(response).to render_template(:edit)
    end

    it 'assigns all teams in a instance variable' do
      teams = FactoryBot.create_list(:team, 3)
      rca = FactoryBot.create(:rca)
      teams << rca.team
      actionitem =  FactoryBot.create(:actionitem)
      teams << actionitem.rca.team
      rca.actionitems << actionitem
      tag = FactoryBot.create(:tag)
      rca.tags << tag
      patch :update, params: { id: rca.id, rca: { title: 'First rca', description: 'this is my first rca', status: 'Completed', team_id: FactoryBot.create(:team).id }, user: { email: 'abcd@go-jek.com' }, actionitem: { list: "[{\"name\":\"root cause\",\"status\":\"Pending\",\"complete_by\":\"2018-07-25\",\"completed_on\":\"\"},{\"name\":\"segmentation fault\",\"status\":\"Completed\",\"complete_by\":\"\",\"completed_on\":\"2018-07-04\"}]" }, tag: { list: "Ruby, CSS, Java" } }
      teams << Rca.find(rca.id).team
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
