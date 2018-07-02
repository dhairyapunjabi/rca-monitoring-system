require 'rails_helper'

RSpec.describe Rca, type: :model do
  describe 'new object' do
    it 'is a Mongoid document' do
      is_expected.to be_mongoid_document
    end
  end

  describe 'data type' do
    it 'of title is string' do
      is_expected.to have_field(:title).of_type(String)
    end

    it 'of description is string' do
      is_expected.to have_field(:description).of_type(String)
    end

    it "of status is string with default value 'Pending'" do
      is_expected.to have_field(:status).of_type(String).with_default_value_of('Pending')
    end
  end

  describe 'validation' do
    it 'should validate presence of title' do
      is_expected.to validate_presence_of(:title).with_message("can't be blank")
    end

    it 'should validate length of title' do
      is_expected.to validate_length_of(:title).within(3..50)
    end

  end

  describe 'association' do
    it 'should associate one rca with one team' do
      is_expected.to belong_to(:team)
    end

    it 'should associate one rca with one user' do
      is_expected.to belong_to(:user)
    end

    it 'should associate one rca with many action items' do
      is_expected.to have_many(:actionitems)
    end

    it 'should associate many rcas with many tags' do
      is_expected.to have_and_belong_to_many(:tags)
    end
  end
end
