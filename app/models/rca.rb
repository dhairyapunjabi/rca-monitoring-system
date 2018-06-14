class Rca
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :users, type: String
  field :status, type: String, default: "Pending"
  field :team_id, type: Integer

  validates_presence_of :title
end
