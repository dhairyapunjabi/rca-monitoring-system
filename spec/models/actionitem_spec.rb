require 'rails_helper'

RSpec.describe Actionitem, type: :model do
  describe 'new object' do
    it 'is a Mongoid document' do
      is_expected.to be_mongoid_document
    end
  end

  describe 'data type' do
    it 'of name is string' do
      is_expected.to have_field(:name).of_type(String)
    end

    it 'of complete_by is string' do
      is_expected.to have_field(:complete_by).of_type(Date)
    end
  end

  describe 'validation' do
    it 'should validate presence of name' do
      is_expected.to validate_presence_of(:name)
    end

    it 'should validate presence of complete_by' do
      is_expected.to validate_presence_of(:complete_by)
    end
  end
end
