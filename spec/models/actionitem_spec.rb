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

    it "of status is string with default value 'Pending'" do
      is_expected.to have_field(:status).of_type(String).with_default_value_of('Pending')
    end
  end

  describe 'validation' do
    it 'should validate presence of name' do
      is_expected.to validate_presence_of(:name)
    end

    it 'should validate presence of complete_by' do
      is_expected.to validate_presence_of(:complete_by)
    end

    it 'should verify that complete_by is on or after today' do
      expect{ Actionitem.create(name: 'Test', complete_by: Date.today+1, rca_id: FactoryBot.create(:rca).id) }.to change(Actionitem, :count).by(1)
      expect{ Actionitem.create(name: 'Test', complete_by: Date.today, rca_id: FactoryBot.create(:rca).id) }.to change(Actionitem, :count).by(1)
      expect{ Actionitem.create(name: 'Test', complete_by: Date.today-1, rca_id: FactoryBot.create(:rca).id) }.to change(Actionitem, :count).by(0)
    end
  end

  describe 'association' do
    it 'should associate one action item with one rca' do
      is_expected.to belong_to(:rca)
    end
  end
end
