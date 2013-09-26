
class Admin::HopsController < Admin::AdminController
  layout "home_layout", only: :hop_photos

  authorize_resource  :unless => :hop_photos
  before_filter :init_hop, only: [:show, :edit_regular, :edit_daily, :tasks]

  def regular
    @tab = 'hops'
    conditions = {daily: false, close: false}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
    @error = params[:error] if params[:error]
  end

    def daily
    @tab = 'daily_hops'
    conditions = {daily: true, close: false}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def current
    @tab = 'current_hops'
    conditions = ["time_start < ? and (time_end > ? or daily = 1) and close = 0", Time.now.utc, Time.now.utc]
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def archived
    @tab = 'archived_hops'
    conditions = {close: true}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def show
    @tasks = @hop.hop_tasks
    @hoppers = @hop.hoppers
    @ads = Ad.ads_for_hop @hop
    @prizes = @hop.prizes
    @exp = params[:exp]
  end

  def new_regular
    @tab = 'hops'
    @hop = Hop.new
    @hop.daily = false
  end

  def new_daily
    @tab = 'daily_hops'
    @hop = Hop.new
    @hop.daily = true
  end

  def create
    params[:hop][:creator_id] = current_user.id
    params[:hop][:close] = false
    @hop = Hop.new(params[:hop])
    if @hop.daily

      @hop.time_end = @hop.time_start.end_of_day

    end
    if @hop.save
      if !@hop.jackpot.blank?
        Prize.create(:hop_id=>@hop.id, :cost=>@hop.jackpot, :place => '1', :user_id=>'', :prize_type=>'place', :accept=>nil)
      end
      redirect_to [:admin, @hop ] , notice: 'Hop was successfully created.'
    else
      @hop.logo = nil
      if @hop.daily

        render action: 'new_daily'
      else

        render action: 'new_regular'
      end
    end

  end

 def render_hoppers

   @hop = Hop.find_by_id(params[:hop_id])
   @hoppers = @hop.hoppers

   render partial: 'hopper_list'
 end

  def edit_regular

  end

  def edit_daily

  end

  def update
    @hop = Hop.find(params[:id])
    if @hop.daily && params[:hop][:time_start]
      #begin
      #  params[:hop][:time_start]= DateTime.strptime( params[:hop][:time_start], '%d/%m/%Y %H:%M:%S')
      #rescue Exception =>e
      #  params[:hop][:time_start]= DateTime.strptime( params[:hop][:time_start], '%Y-%m-%d %H:%M:%S %z')
      # end
      #params[:hop][:time_end] = DateTime.new( params[:hop][:time_start].year , params[:hop][:time_start].month , ( params[:hop][:time_start].day.to_i+1),0,0,0,  params[:hop][:time_start].zone.to_s )

    end
    if User.can_edit?(current_user, @hop.creator_id) && @hop.update_attributes(params[:hop])
      if @hop.daily
        @hop.update_attributes(:time_end=>  @hop.time_start.end_of_day)
      end


      for i in params[:hop]

        if i.include?('jackpot')


          prize = Prize.where(:hop_id => @hop.id, :place=>'1').first
          puts params[:hop][:jackpot].inspect
          if prize
            prize.update_attributes(:cost => params[:hop][:jackpot])
          else
            Prize.create(:hop_id=>@hop.id, :cost=>@hop.jackpot, :place => '1st', :user_id=>'', :prize_type=>'place', :accept=>nil)
         end
        end
      end
      redirect_to [:admin, @hop ], notice: 'Hop was successfully updated.'
    else
      if @hop.daily
        render action: 'edit_daily'
      else

        @hop.errors.messages[:access]=["Can not edit this hop "] if @hop.errors.messages.blank?

        render action: 'edit_regular'
      end
    end
  end

  def destroy
    @hop = Hop.find(params[:id])
    daily_hop = @hop.daily
    if  User.can_edit?(current_user, @hop.creator_id)
      @hop.destroy
      if daily_hop
        redirect_to admin_daily_hops_path
      else
        redirect_to admin_regular_hops_path
      end
    else
      redirect_to admin_regular_hops_path
    end
  end

  def close
    @hop = Hop.find(params[:id])
    if User.can_edit?(current_user, @hop.creator_id)
     if @hop.update_attributes( close: 1)
       flash[:notice] = 'Hop was successfully closed.'
      else
          flash[:error] = 'Error update hop'
      end
    else
      flash[:error] = 'Have not access '

    end
    redirect_to :back
  end

  def sub_layout
    'admin/hops_tabs'
  end

  def print_hop_to_pdf
     output = PdfWritter::TestDocument.new.print_hop_pdf(params[:id])
      respond_to do |format|
        format.pdf {
          send_data output, :filename => "Hop.pdf", :type => "application/pdf", :disposition => "inline"
        }
      end
  end
  def print_hop_list_to_pdf
    (params[:id] == 'current')? @hops = Hop.where(:close => false).all : @hops = Hop.where(:close => true  ).all
    respond_to do |format|
      format.pdf {
        output = PdfWritter::TestDocument.new.hops_to_pdf(@hops)
        send_data output, :filename => "Current_hops.pdf", :type => "application/pdf", :disposition => "inline"
      }
    end
  end

  def print_hop_to_excel
    @hop = Hop.find_by_id(params[:id])
    respond_to do |format|
      format.xls{
        last_col = 0
        clients = Spreadsheet::Workbook.new
        list = clients.create_worksheet :name => ' Hop'
        list.row(1).push "Hop"
        list.row(3).concat ['Id', 'Name', 'Code', 'Time start', 'Time end','Jackpot', 'Special event', 'Price','Showprod id', 'Showprod  contact','Showprod name', 'Showprod  email', 'Showprod  phone' ]
        [@hop].each_with_index { |hop, i|
          list.row(i+4).push hop.id,hop.name,hop.code,hop.time_start.to_s,hop.time_end.to_s,hop.jackpot,
                             hop.event,hop.price,hop.producer.id, hop.producer.contact,"#{hop.producer.first_name.to_s + ' ' +hop.producer.last_name.to_s}",
                             hop.producer.email, hop.producer.phone
        }


        list.row(6).push "Winner"
        list.row(8).concat %w{Place Prize}
        @hop.prizes.each_with_index { |winner, i|
          list.row(i+9).push winner.place, winner.cost
          last_col =  last_col + i
        }

        list.row(last_col+10).push 'Hop item'
       list.row(last_col+12).concat ['Id', 'Hop item description', 'Sponsor', 'Sponsor id', 'PTS', 'Bonus', 'Price', 'Amt paid']
        z = last_col+13
        @hop.hop_tasks.each_with_index { |item, i|
          list.row(i+z).push item.id, item.text,"#{ item.sponsor.first_name + ' ' + item.sponsor.last_name}", item.sponsor_id, item.pts,item.bonus.to_i, item.price, item.amt_paid
          last_col =  last_col + i
        }

        list.row(last_col+14).push 'Hop ad'
        list.row(last_col+16).concat ['Position', 'Advertiser', 'Advertiser id', 'Logo', 'Price', 'Amt paid', 'Link to ad']
        z = last_col+17
        @hop.ads.each_with_index { |ad, i|
          list.row(i+z).push ad.ad_type,"#{ ad.advertizer.first_name + ' ' + ad.advertizer.last_name}", ad.advertizer.id, ad.picture_file_name, ad.price, ad.amt_paid, ad.link
          last_col =  last_col + i
        }


        header_format = Spreadsheet::Format.new :color =>:green, :size => 10
        list.row(1).default_format = header_format
        #output to blob object
        blob = StringIO.new("")
        clients.write blob
        #respond with blob object as a file
        send_data blob.string, :type => 'xls', :filename =>'Hop.xls'

      }
    end
  end

  def print_hops_to_excel

    (params[:id] == 'current')? @hops = Hop.where(:close => false).all : @hops = Hop.where(:close => true  ).all


    respond_to do |format|
      format.xls{

          clients = Spreadsheet::Workbook.new
          list = clients.create_worksheet :name => 'Hop List'
         (@hops.first.close)?  (list.row(1).push " Archived hops") : (list.row(1).push " Current hops")

          list.row(3).concat ['Id', 'Name', 'Time start', 'Time end', 'Registered hoppers', 'Items', "Ads"]
          @hops.each_with_index { |hop, i|
            list.row(i+4).push hop.id,hop.name,hop.time_start.to_s,hop.time_end.to_s, hop.hoppers.count, hop.hop_tasks.sum(:amt_paid), hop.ads.sum(:amt_paid)
          }
          header_format = Spreadsheet::Format.new :color =>:green, :size => 10
          list.row(1).default_format = header_format
          #output to blob object
          blob = StringIO.new("")
          clients.write blob
          #respond with blob object as a file
          send_data blob.string, :type => 'xls', :filename =>'HopList.xls'

       }
    end

  end


  def import_from_excel

      @hop = Hop.new
      begin
        import_file = params[:excel]

        @new_hop, @hop_items,@hop_ads, @winners = Hop.import_from_excel(import_file)
        @hoppers = []
        @hop = Hop.create!(@new_hop)

      rescue Exception =>e

        redirect_to admin_regular_hops_path({:error =>"bad data syntax in file" })
      else

        if @hop.save
          @exp = []
          @exp << @hop.errors.messages unless @hop.errors.messages.blank?
          @exp << Hop.save_items_and_add_from_excel(@hop, @hop_items, @hop_ads, @winners)
          puts @hop.errors.messages

          redirect_to   admin_hop_path(:id =>@hop, :exp=> @exp )
        else

         redirect_to  action: 'regular'
        end


      end





  end

 def hop_photos
   @hop=Hop.find_by_id(params[:hop_id])
   @ads = @hop.ads.all if  @hop
   @hop_task_photo = @hop.hop_tasks.all.map{|item| item.user_hop_tasks}.flatten! if @hop
 end

  def export_photos_zip

    input_filenames =[]
    params[:id].each do |id|
      task = UserHopTask.find_by_id(id)
      input_filenames << task

    end
    temp = Tempfile.new("Photo.zip")

    input_filenames.compact!
    folder = Rails.root.join("app/assets/images")
    #input_filenames = ['f.png', 'g.2.png', 'businesspage.jpg']
    zipfile_name = Rails.root.join.to_s  + temp.path


    begin
      Zip::ZipFile.open(zipfile_name , Zip::ZipFile::CREATE) do |zipfile|
        input_filenames.each do |filename|
          puts '----------------------222'
          zipfile.add(rand(3).to_s+rand(3).to_s+ rand(3).to_s + filename.photo_file_name , filename.photo.path) unless filename.photo_file_name.nil?
          puts '----------------------333'
        end
      end

      send_file zipfile_name , :type => 'application/zip', :disposition => 'attachment', :filename => "Photos.zip"
     temp.delete

    rescue Exception => e
      puts '----------------------3444444444444444444444444444444'
      puts "---------------------#{e}----------------"

      temp.delete
    end
    #folder = "Users/me/Desktop/stuff_to_zip"
    #input_filenames = ['image.jpg', 'description.txt', 'stats.csv']
    #
    #zipfile_name = "/Users/me/Desktop/archive.zip"
    #
    #Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
    #  input_filenames.each do |filename|
    #    # Two arguments:
    #    # - The name of the file as it will appear in the archive
    #    # - The original file, including the path to find it
    #    zipfile.add(filename, folder + '/' + filename)
    #  end


    #render :text => params


  end

  private

  def init_hop
    @hop = Hop.find(params[:id])
    if @hop.daily
      @tab = 'daily_hops'
    else
      @tab = 'hops'
    end
  end



end
