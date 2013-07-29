class Admin::PrizesController < ApplicationController

  def index
    @hop = Hop.find(params[:hop_id])
    @prizes = @hop.prizes
    render partial: 'list'
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
    @prize = Prize.new(params[:prize])
    if @prize.save
      render text: 'ok'
    else
      render partial: 'form'
    end
  end

  def update
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
