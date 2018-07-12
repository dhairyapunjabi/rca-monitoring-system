require 'rails_helper'

describe Clockwork do
  after(:each) { Clockwork::Test.clear! }
  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  it "runs the job twice" do
    actionitem = FactoryBot.create(:actionitem)
    start_time = Time.new(2018, 07, 12, 0, 0, 0)
    end_time = Time.new(2018, 07, 14, 0, 0, 0)

    Clockwork::Test.run(file: './app/clock.rb', start_time: start_time, end_time: end_time, tick_speed: 1.day)

    expect(Clockwork::Test.ran_job?("send_email")).to be_truthy
    expect(Clockwork::Test.times_run("send_email")).to eq 2
    expect(Clockwork::Test.block_for("send_email")).to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
