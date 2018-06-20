FactoryBot.define do
  factory :rca do
    title 'My first Rca'
    description 'hi this is our first rca.'
    team_id { FactoryBot.create(:team).id }
    user_id { FactoryBot.create(:user).id }
  end
end
