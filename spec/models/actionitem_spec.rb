require 'rails_helper'

RSpec.describe Actionitem, type: :model do
  describe 'new object' do
    it 'is a Mongoid document' do
      is_expected.to be_mongoid_document
    end
  end
end