class Hopper < ActiveRecord::Base

  def self.search( id,name, params_1, params_2)
    if params_1==:hop_id
      params_1=''
    end

    puts("--------------------------------------------------------------------------")

    if (!id.blank? && !name.blank?)
      @user = User.where(params_1 => id, params_2 => name).first
    elsif !(id.blank?)
      @user = User.where(params_1=>id).first
    elsif !(name.blank?)
      @user = User.where(params_2 => name).first
    else
      @user=[]
    end
    @user
  end


end
