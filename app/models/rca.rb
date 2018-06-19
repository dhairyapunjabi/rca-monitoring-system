# This defines data-type and validations of a Rca document.
class Rca
  include Mongoid::Document
  belongs_to :team
  field :title, type: String
  field :description, type: String
  field :users, type: String
  field :status, type: String, default: 'Pending'

  validates_presence_of :title
end
