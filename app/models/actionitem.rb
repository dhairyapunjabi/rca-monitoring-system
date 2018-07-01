class Actionitem
  include Mongoid::Document
  belongs_to :rca
  field :name, type: String
  field :complete_by, type: Date
  field :status, type: String, default: 'Pending'

  validates :name, presence: true
  validates :complete_by, presence: true, :timeliness => {:on_or_after => lambda { Date.current }, :type => :date}
end
