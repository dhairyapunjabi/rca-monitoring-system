class Team
  include Mongoid::Document
  has_many :rcas
  field :name, type: String
  field :slack_webhook_url, type: String

  validates :name, presence: true
end
