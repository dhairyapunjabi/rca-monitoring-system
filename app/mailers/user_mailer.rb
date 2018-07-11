class UserMailer < ApplicationMailer
  def reminder_email
    mail(to: params[:user].email,
         body: "Your action item '#{params[:actionitem].name}' is still pending. Attend to it asap. This mail is just for information purpose and should not be replied to.",
         content_type: "text/html",
         subject: "Action Item is still pending")
  end
end
