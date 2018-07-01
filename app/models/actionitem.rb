class Actionitem
  include Mongoid::Document
  belongs_to :rca
  field :name, type: String
  field :complete_by, type: Date
  field :status, type: String, default: 'Pending'
  field :completed_on, type: Date

  validates :name, presence: true
  validates :complete_by, presence: true, if: :status1?
  validates :complete_by, :timeliness => {:on_or_after => lambda { Date.current }, :type => :date},if: :status1?

  def status1?
    status == 'Pending'
  end
end
