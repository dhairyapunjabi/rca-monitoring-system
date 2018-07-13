require 'rails_helper'

RSpec.describe PingController, type: 'controller' do
  describe 'health_check' do
    it "renders the json 'status: ok'" do
      get :health_check
      expect(response.body).to eq('pong')
    end
  end
end
