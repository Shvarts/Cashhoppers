class UserMailer < ActionMailer::Base
  default from: 'notification@example.com'

  def welcome_email(user)
  	puts "---------------------Welcome Email---------------------------"
  	puts user.email
  	puts "-------------------------------------------------------------"
    @user = user
    @url  = "http://perechin.net:3000/users/sign_in"
    mail(:to =>  'viktor.danch@gmail.com', :from => 'sender@gmail.com', :subject => "Welcome to My Awesome Site")
  end

  def send_email_for_select_user(user,href, subject, content, file)
    attachments['noavatar.jpeg']=  File.read('public/images/noavatar.jpeg')

    @text= content
    @href = href
    @file = file
     @user = user
    @url  = "http://perechin.net:3000/users/sign_in"
     mail(:to => 'viktor.danch@gmail.com', :subject => subject)
  end


end
