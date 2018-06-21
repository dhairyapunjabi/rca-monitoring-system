class Actionitem
  include Mongoid::Document
  field :name, type: String
  field :complete_by, type: Date

  validates :name, presence: true
end
