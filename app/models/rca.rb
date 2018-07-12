# This defines data-type and validations of a Rca document.
class Rca
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :team
  belongs_to :user
  has_many :actionitems
  has_and_belongs_to_many :tags
  field :title, type: String
  field :description, type: String
  field :status, type: String, default: 'Pending'

  validates :title, presence: { message: "can't be blank" }, length: { in: 3..50 }
end
