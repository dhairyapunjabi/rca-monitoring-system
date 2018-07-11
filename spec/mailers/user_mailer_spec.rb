require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  actionitem = FactoryBot.create(:actionitem)
  mail = UserMailer.with(user: actionitem.rca.user, actionitem: actionitem).reminder_email

  it "renders the headers" do
    expect(mail.subject).to eq("Action Item is still pending")
    expect(mail.to).to eq([actionitem.rca.user.email])
    expect(mail.from).to eq(["aajay980@gmail.com"])
  end

  it "renders the body" do
    expect(mail.body.encoded).to match("Your action item '#{actionitem.name}' is still pending. Attend to it asap. This mail is just for information purpose and should not be replied to.")
  end
end
