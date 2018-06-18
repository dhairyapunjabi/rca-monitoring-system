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
end
