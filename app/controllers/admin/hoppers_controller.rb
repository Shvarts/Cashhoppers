class Admin::HoppersController < Admin::AdminController
  include ::PdfWritter

  def find_hopper

    @tab = 'find_hoppers'

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

  def search_user
    params[:page] ||= 1
    params[:per_page] ||= 7
    @users = User.paginate page: params[:page], per_page: params[:per_page]
    render :partial=> 'users_list'
  end



  def search_hop_list
    params[:page] ||= 1
    params[:per_page] ||= 7
    @hops = Hop.paginate page: params[:page], per_page: params[:per_page]
     render partial: 'users_hop_list'
  end

  def search_zip_list
    params[:page] ||= 1
    params[:per_page] ||= 7
    @zips = User.group(:zip).select(:zip).paginate page: params[:page], per_page: params[:per_page]
     render partial: 'users_zip_list'
  end



  def select_user
    @user = User.find_by_id(params[:id])
    render :partial => 'hopper_info'
  end


  def select_hop
    @users = Hop.find_by_id(params[:id]).hoppers.all
    render :partial => 'generate_hop_list'

  end

  def select_zip
    @users = User.where(:zip => params[:zip]).all
    render :partial => 'generate_hop_list'

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

  def hopper_to_pdf
    if  params[:id]
      output = PdfWritter::TestDocument.new.to_pdf_hopper(params[:id])
      respond_to do |format|
        format.pdf {
          send_data output, :filename => "Hopper.pdf", :type => "application/pdf", :disposition => "inline"
        }
      end
    end
  end

  def export_to_excel
    @gamers = []
    for i in params[:id]
      @gamers  << User.find_by_id(i)
    end


    respond_to do |format|
      format.xls{

          clients = Spreadsheet::Workbook.new
          list = clients.create_worksheet :name => 'List of cliets'
          list.row(1).push "Hoppers list"
          list.row(3).concat %w{Id User_name First_name Last_name Zip Email}
          @gamers.each_with_index { |client, i|
            list.row(i+4).push client.id,client.user_name,client.first_name,client.last_name,client.zip,client.email
          }
          header_format = Spreadsheet::Format.new :color =>:green, :size => 10
          list.row(1).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          clients.write blob
          #respond with blob object as a file
          send_data blob.string, :type => 'xls', :filename =>'Hoppers_list.xls'

      }
    end
  end

end
