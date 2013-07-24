class Admin::HoppersController < Admin::AdminController

  def find_hopper
    @users = User.all
    @tab = 'find_hoppers'
  end

  def hopper_list
    @users = User.all
    @tab = 'generate_hoppers_list'
  end



  def search_hoppers
    @user = Hopper.search(params[:hop_id],params[:zip], :hop_id, :zip)
    @id = []

      for i in @user do
        @id<< i.id
      end

    render 'admin/hoppers/hopper_list'
  end

  def sub_layout
    'admin/hoppers_tabs'
  end

   def search_by_id
     conditions = 0
     conditions = ["id LIKE ? OR id LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
     @users = User.paginate(page: params[:page], per_page:9, conditions:  conditions)

     @user  = User.find_by_id(params[:id])   if params[:id]
    (params[:id])?  (render 'admin/hoppers/find_hopper') : (render :partial=> 'users_id_list')


   end

  def search_by_name

    conditions = 0
    conditions = ["user_name LIKE ? OR user_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
    @users = User.paginate(page: params[:page], per_page:9, conditions:  conditions)


    @user  = User.find_by_id(params[:name])   if params[:name]
    (params[:name])?  (render 'admin/hoppers/find_hopper') : (render :partial=> 'users_name_list')


  end

  def search_by_zip

  end

  def search_by_hop

  end


end
