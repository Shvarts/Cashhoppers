class UserMailer < ActionMailer::Base

  def confirmation_instructions(user)
  	puts user.email
    @user = user
    @url  = "http://perechin.net:3000/users/sign_in"
    mail(:to =>  user.email, :from => 'sender@gmail.com', :subject => "Welcome to My Awesome Site")
  end

  def email_alert(recipients, message, attachment)
    @message = message
    attachments[attachment.original_filename] = attachment.read
    mail(:to => recipients, :from => 'sender@gmail.com', :subject => @message.subject)
  end

end
