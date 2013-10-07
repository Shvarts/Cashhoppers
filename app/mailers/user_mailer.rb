class UserMailer  < ActionMailer::Base

  def confirmation_instructions(user)
  	puts user.email
    @user = user
    @url  = "http://ec2-54-227-42-108.compute-1.amazonaws.com/users/sign_in"
    attachments['logo_1.jpg'] = File.read("#{Rails.root}/app/assets/images/template_1.jpg")
    mail(:to =>  user.email, :from => 'sender@gmail.com', :subject => "Welcome to My Awesome Site")
  end

  def email_alert(recipients, message, attachment,template_data)
    @message = message


    if !template_data.blank?
      if @hop = Hop.find_by_name(template_data[:hop_name])


        @prize = Prize.where(place: template_data[:prize_place], hop_id: @hop.id).first if template_data[:prize_place]
      else
        @hop_name = template_data[:hop_name]
      end

      unless template_data[:prize_place]
        @hop = Hop.find_by_name(template_data[:hop_name])

      end
    end
    sender = (@message.sender_id.blank?)?  'HOPMASTER@cashhoppers.com' : @message.sender.email.to_i
    attachments['image.jpg'] = attachment.read  if  attachment
    attachments['logo_1.jpg'] = File.read("#{Rails.root}/app/assets/images/template_1.jpg")
    attachments['logo_2.jpg'] = File.read("#{Rails.root}/app/assets/images/template_2.jpg")

    mail(:to => recipients, :from => sender, :subject => @message.subject)
  end

end
