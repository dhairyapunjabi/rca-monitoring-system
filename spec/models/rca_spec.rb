require 'rails_helper'

RSpec.describe Rca, type: :model do
  describe "new object" do
    it "is a Mongoid document" do
      is_expected.to be_mongoid_document
    end
  end

  describe "data type" do
    it "of title is string" do
      is_expected.to have_field(:title).of_type(String)
    end

    it "of description is string" do
      is_expected.to have_field(:description).of_type(String)
    end

    it "of users is array" do
      is_expected.to have_field(:users).of_type(Array)
    end

    it "of status is string with default value 'Pending'" do
      is_expected.to have_field(:status).of_type(String).with_default_value_of("Pending")
    end

    it "of team_id is integer" do
      is_expected.to have_field(:team_id).of_type(Integer)
    end
  end

  describe "validation" do
    it "should validate presence of title" do
      is_expected.to validate_presence_of(:title)
    end
  end
end
