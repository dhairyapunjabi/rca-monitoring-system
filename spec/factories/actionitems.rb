FactoryBot.define do
  factory :actionitem do
    name "First actionitem"
    status "Pending"
    complete_by { Date.current }
    completed_on { Date.current }
    rca_id { FactoryBot.create(:rca).id }
  end
end
