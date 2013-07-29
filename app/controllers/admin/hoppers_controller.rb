class Admin::HoppersController < Admin::AdminController
  include ::PdfWritter

  def find_hopper

    @tab = 'find_hoppers'
    if  params[:id]
    output = PdfWritter::TestDocument.new.to_pdf_hopper(params[:id])
    respond_to do |format|
      format.pdf {
        send_data output, :filename => "Hopper.pdf", :type => "application/pdf", :disposition => "inline"
      }
      end
    end
  end

  def hopper_list
   @tab = 'generate_hoppers_list'


   if  params[:id]
     output = PdfWritter::TestDocument.new.to_pdf_hopper_list(params[:id])
     respond_to do |format|
       format.pdf {
         send_data output, :filename => "HopperList.pdf", :type => "application/pdf", :disposition => "inline"
       }
     end
   end


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

    conditions = []
    conditions = ["zip LIKE ? OR zip LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
    @zips = User.group(:zip).select(:zip)
    @zips = @zips.paginate(:page => 1, :per_page => 9,  conditions:  conditions )

    if params[:zip]
      @users  = User.where(:zip => params[:zip]).all

    end
    (params[:zip])?  (render 'admin/hoppers/hopper_list') : (render :partial=> 'users_zip_list')


  end

  def search_by_hop

    conditions = ["name LIKE ? OR name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
    @hops = Hop.paginate(page: params[:page], per_page:9, conditions:  conditions)

    if params[:hop]
      hop  = Hop.find_by_id(params[:hop])
      @users = hop.hoppers
   end

    (params[:hop])?  (render 'admin/hoppers/hopper_list') : (render :partial=> 'users_hop_list')
  end
end
