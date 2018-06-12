class Rca
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :users, type: Array
  field :status, type: String, default: "Pending"
end
