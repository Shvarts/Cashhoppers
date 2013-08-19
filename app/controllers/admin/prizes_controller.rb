class Admin::PrizesController < ApplicationController
  #load_and_authorize_resource
  def index
    @hop = Hop.find(params[:hop_id])
    @prizes = @hop.prizes
    render partial: 'list'
  end

  def random_user
    @prize = Prize.find_by_id(params[:id])
    hop = @prize.hop
    hoppers = hop.hoppers
    winner =  hoppers[rand(hop.hoppers.length)]
    if @prize.update_attributes(:user_id => winner.id)
      render text: 'ok'
    else
      render partial: 'form'
    end

  end




  def new
    @hop = Hop.find(params[:hop_id])
    @prize = @hop.prizes.build
    render partial: 'form'
  end

  def edit
    @prize = Prize.find(params[:id])
    @hop = @prize.hop
    render partial: 'form'
  end


  def create

    params[:prize][:place]= 'random' if params[:prize][:prize_type] == 'random'
    @prize = Prize.new(params[:prize])
    if @prize.save
      render text: 'ok'
    else
      render partial: 'form'
    end

  end

  def update

    params[:id]= params[:prize_id] if params[:prize_id]
    @prize = Prize.find(params[:id])
    if @prize.update_attributes(params[:prize])
      render text: 'ok'
    else
      render partial: 'form'
    end

  end

  def accept_user
    @prize = Prize.find_by_id(params[:prize_id])
    @prize.update_attributes(:accept => true)
    recipients = @prize.user.email

    message_data = {:receiver_id=> @prize.user.id, :sender_id=>current_user.id,
                    :subject=> 'CONGRATULATIONS HOPPER!',
                    :text => '',
                    :template_id => 2

    }

    message = EmailAlert.new(message_data)
    @messages = [message]


    attachment = nil
    template_data = {}
    template_data[:hop_name] = @prize.hop.name
    template_data[:prize_place]=@prize.place
    UserMailer.email_alert(recipients, message, attachment,template_data).deliver

    render text:"ok"
  end


  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy
    render text: 'ok'
  end
end
