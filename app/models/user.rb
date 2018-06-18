class User
  include Mongoid::Document
  field :email, type: String

  validates :email, presence: true, format: { with: /([a-zA-Z0-9]+)([\.{1}])?([a-zA-Z0-9]+)\@go-jek([\.])com/ }
end
