class Actionitem
  include Mongoid::Document
  belongs_to :rca
  field :name, type: String
  field :complete_by, type: Date
  field :status, type: String, default: 'Pending'
  field :completed_on, type: Date

  validates :name, presence: true
  validates :complete_by, presence: true, if: :status1?
  validates :complete_by, :timeliness => {:on_or_after => lambda { Date.current }, :type => :date}, if: :status1?
  validates :completed_on, presence: true, if: :status2?
  validates :completed_on, :timeliness => {:on_or_before => lambda { Date.current }, :type => :date}, if: :status2?

  def status1?
    status == 'Pending'
  end

  def status2?
    status == 'Completed'
  end
end
