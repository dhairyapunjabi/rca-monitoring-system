require 'rails_helper'

RSpec.describe Rca, type: :model do
  context "When testing the database type" do
    it "should be Mongoid Document" do
      is_expected.to be_mongoid_document
    end
  end
end
