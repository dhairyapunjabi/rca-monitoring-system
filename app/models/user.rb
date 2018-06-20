class User
  include Mongoid::Document
  has_many :rcas
  field :email, type: String

  validates :email, presence: true, format: { with: /([a-zA-Z0-9]+)([\.{1}])?([a-zA-Z0-9]+)\@go-jek([\.])com/ }
end
