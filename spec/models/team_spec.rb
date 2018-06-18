require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'new object' do
    it 'is a Mongoid document' do
      is_expected.to be_mongoid_document
    end
  end

  describe 'data type' do
    it 'of name is string' do
      is_expected.to have_field(:name).of_type(String)
    end
  end

  describe 'validation' do
    it 'should validate presence of name' do
      is_expected.to validate_presence_of(:name)
    end
  end
end
