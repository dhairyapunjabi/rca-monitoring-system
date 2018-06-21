class Actionitem
  include Mongoid::Document
  field :name, type: String
  field :complete_by, type: Date

end
