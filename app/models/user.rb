class User
  include Mongoid::Document
  field :email, type: String

  validates :email, presence: true
end
