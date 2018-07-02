class Tag
  include Mongoid::Document
  has_and_belongs_to_many :rcas
  field :name, type: String

  validates :name, presence: true, length: { maximum: 25 }
end
