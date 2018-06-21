class Actionitem
  include Mongoid::Document
  field :name, type: String
  field :complete_by, type: Date

  validates :name, presence: true
  validates :complete_by, presence: true, :timeliness => {:on_or_after => lambda { Date.current }, :type => :date}
end
