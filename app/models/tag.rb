class Tag
  include Mongoid::Document
  field :name, type: String

  validates :name, presence: true, length: { maximum: 25 }
end
