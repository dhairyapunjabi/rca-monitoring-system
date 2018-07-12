require 'clockwork'
include Clockwork
require './config/boot'
require './config/environment'

every(1.day,'send_email', at: '00:00') do
    actionitems = Actionitem.all.to_a
    actionitems.each do |actionitem|
      if (actionitem.status == 'Pending' && Date.today == actionitem.complete_by)
        UserMailer.with(user: actionitem.rca.user, actionitem: actionitem).reminder_email.deliver_now
      end
    end
end
