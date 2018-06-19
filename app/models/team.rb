class Team
  include Mongoid::Document
  has_many :rcas
  field :name, type: String

  validates :name, presence: true
end
