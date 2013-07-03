class UserMailer < ActionMailer::Base
  default from: "svarts@ukr.net"

  def welcome_email(user)
  	puts "---------------------Welcome Email---------------------------"
  	puts user.email
  	puts "-------------------------------------------------------------"
    @user = user
    @url  = "http://perechin.net:3000/users/sign_in"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
