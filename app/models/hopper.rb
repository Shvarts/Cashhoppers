class Hopper < ActiveRecord::Base

  def self.search( id,name, params_1, params_2)
    if params_1==:hop_id && (!(id.blank?))

      hop=Hop.find_by_id(id)
      if hop
        @user = hop.hoppers.all
      else
        @user=[]
      end
    elsif (!id.blank? && !name.blank?)
      @user = User.where(params_1 => id, params_2 => name)
    elsif !(id.blank?)
      @user = User.where(params_1=>id)
    elsif !(name.blank?)
      @user = User.where(params_2 => name)
    else
      @user=[]
    end
    @user
  end


end
