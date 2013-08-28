class Admin::PrizesController < ApplicationController
  load_and_authorize_resource
  def index
    @hop = Hop.find(params[:hop_id])
    @prizes = @hop.prizes
    render partial: 'list'
  end

  def random_user
    @prize = Prize.find_by_id(params[:prize_id])

    puts @prize.inspect
    puts params


    puts hop = @prize.hop

    hoppers_id = hop.hoppers.map{|hopper| hopper.id} - hop.prizes.map{|prize| prize.user_id}.compact!
    winner_id =  hoppers_id[rand(hoppers_id.length)]

    if @prize.update_attributes(:user_id => winner_id)
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




  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy
    render text: 'ok'
  end
end
