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
  end
end
