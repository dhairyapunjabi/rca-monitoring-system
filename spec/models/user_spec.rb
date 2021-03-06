require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'new object' do
    it 'is a Mongoid document' do
      is_expected.to be_mongoid_document
    end
  end

  describe 'data type' do
    it 'of email-address is string' do
      is_expected.to have_field(:email).of_type(String)
    end
  end

  describe 'validation' do
    it 'should validate presence of email' do
      is_expected.to validate_presence_of(:email).with_message("can't be blank")
    end

    it 'should validate format of email' do
      is_expected.to validate_format_of(:email).with_message("is invalid")
    end

    it 'should validate length of email' do
      is_expected.to validate_length_of(:email).with_maximum(30)
    end
  end

  describe 'association' do
    it 'should associate 1 user with many rcas' do
      is_expected.to have_many(:rcas)
    end
  end
end
