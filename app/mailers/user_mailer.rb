class UserMailer < ActionMailer::Base

  def confirmation_instructions(user)
  	puts user.email
    @user = user
    @url  = "http://perechin.net:3000/users/sign_in"
    mail(:to =>  user.email, :from => 'sender@gmail.com', :subject => "Welcome to My Awesome Site")
  end

  def email_alert(recipients, message, attachment,template_data)
    @message = message
    if !template_data.blank?
      @place = template_data[:prize_place] if template_data[:prize_place]
      @hop = Hop.find_by_name(template_data[:hop_name])
      unless template_data[:prize_place]
        @hop = Hop.find_by_name(template_data[:hop_name])

      end
    end
    attachments['image.jpg'] = attachment.read  if  attachment
    attachments['logo_1.jpg'] = File.read("#{Rails.root}/app/assets/images/template_1.jpg")
    attachments['logo_2.jpg'] = File.read("#{Rails.root}/app/assets/images/template_2.jpg")

    mail(:to => recipients, :from => 'sender@gmail.com', :subject => @message.subject)
  end

end
