class Rca
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :users, type: Array
end
