class UserMailer < ActionMailer::Base


  def welcome_email(user)
  	puts "---------------------Welcome Email---------------------------"
  	puts user.email
  	puts "-------------------------------------------------------------"
    @user = user
    @url  = "http://perechin.net:3000/users/sign_in"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

  def send_email_for_select_user(user,href, subject, content, file)
    attachments.inline['image']= ''   #File.read()
    attachments.inline['content']=  Base64.encode64('text text text')
    puts "-------------------- Email for user ---------------------------"
    puts user.email
    puts "-------------------------------------------------------------"
    @user = user
    @url  = "http://perechin.net:3000/users/sign_in"
    mail(:to => user.email, :from => href  , :subject => subject )
  end


end
