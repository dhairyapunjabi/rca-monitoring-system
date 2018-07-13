require 'clockwork'
include Clockwork
require './config/boot'
require './config/environment'
require 'slack-notifier'

every(1.day,'send_email', at: '00:00') do
  actionitems = Actionitem.all.to_a
  actionitems.each do |actionitem|
    if (actionitem.status == 'Pending' && Date.today == actionitem.complete_by)
      UserMailer.with(user: actionitem.rca.user, actionitem: actionitem).reminder_email.deliver_now
      notifier = Slack::Notifier.new actionitem.rca.team.slack_webhook_url
      notifier.ping "RCA: #{actionitem.rca.title} \n Your action item '#{actionitem.name}' submitted by #{actionitem.rca.user.email} is still pending.\n Attend to it asap."
    end
  end
end
