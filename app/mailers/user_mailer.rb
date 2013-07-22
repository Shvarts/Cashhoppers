class UserMailer < ActionMailer::Base
  default from: 'notification@example.com'

  def confirmation_instructions(user)
  	puts "---------------------Welcome Email---------------------------"
  	puts user.email
  	puts "-------------------------------------------------------------"
    @user = user
    @url  = "http://perechin.net:3000/users/sign_in"
    mail(:to =>  user.email, :from => 'sender@gmail.com', :subject => "Welcome to My Awesome Site")
  end

  def send_email_for_select_user(message)

    @message = Message.find_by_id(message)
    i= @message.file.url.index('?')


    attachments['file'] =  File.read('public/' + @message.file.url[1...i])  if !@message.file.url.include?('no_ad_picture')
    @text= @message.text
    @href = @message.email_author

     @user = @message.receiver.first_name
    @url  = "http://perechin.net:3000/users/sign_in"
     mail(:to => @message.receiver.email, :subject => @message.subject)  #@message.receiver.email
  end


end
