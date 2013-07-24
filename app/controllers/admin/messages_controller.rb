class Admin::MessagesController < Admin::AdminController

  class TestDocument < Prawn::Document
    def to_pdf
      text "Hello World!"
      render
    end
  end


  before_filter :authenticate_user!

  def message_history
    @tab = 'message_tool'
    @messages = Message.where(:email=>false)
  end

  def email_history
    @tab = 'email_tool'
    @emails=Message.find_all_by_email(true)
  end

  def create_email
       receiver_id = Message.users_from_hop(params[:hopId])  if params[:hopId]
       receiver_id = Message.users_from_zip(params[:zipId])   if params[:zipId]
       receiver_id = params[:userId]                          if params[:userId]
        (params[:email])? email = true : email = false

      if ! receiver_id.nil?
        n = Message.send_emails_to(params[:message],current_user.id, receiver_id, email)
        (email)? flash[:success]=" #{n} emails  have created"  : flash[:success]=" #{n} messages  have created"
       else
         (email)? flash[:error]=" emails  have  not created" : flash[:error]=" emails  have  not created"
      end

     (params[:email])? (redirect_to admin_messages_email_tool_path) : (redirect_to admin_messages_message_tool_path)

  end




  def email_tool
    @tab = 'email_tool'

     flash[:id] = Message.create_users_id_list(params[:id_user],flash[:id]) if params[:id_user]

    conditions = Message.conditions_for_users(params[:query])
    flash[:id] =  flash[:id]

    @message= Message.new

    @users = User.paginate(page: params[:page], per_page:9, conditions: conditions )
    render partial: 'users_list' if params[:page] || params[:query]|| params[:id_user]


  end

  def message_tool
    @tab = 'message_tool'

    conditions = Message.conditions_for_users(params[:query])
    @message= Message.new
   @users = User.paginate(page: params[:page], per_page:9, conditions: conditions )
    render partial: 'users_list' if params[:page] || params[:query]




  end

  def show
    output = TestDocument.new.to_pdf
    #render :text => output = TestDocument.new.to_pdf
    @message = Message.find_by_id(params[:id])
    respond_to do |format|
      format.pdf {
        send_data output, :filename => "hello.pdf", :type => "application/pdf", :disposition => "inline"
      }
      format.html {
        render :text => "<h1>Use .pdf</h1>".html_safe
      }
    end
    #Prawn::Document.generate('hello.pdf') do |pdf|
    #    pdf.text("Hello Prawn!")
    #
    #end
    #pdf = Prawn::Document.new
    #pdf.text("Hello Prawn!")
    #pdf.render_file "Text.pdf"
  end

  def destroy
    @message = Message.find_by_id(params[:id])
    email = @message.email
    @message.destroy
    if !email
      redirect_to admin_messages_message_history_path
    else
      redirect_to admin_messages_email_history_path
    end
  end


  def sub_layout
    'admin/messages_tabs'
  end

  def find_hop

    conditions = ["name LIKE ? OR name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
    @hops = Hop.paginate(page: params[:page], per_page:9, conditions:  conditions)
    render :partial=> 'hops_list'




  end


  def find_zip

   conditions = ["zip LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
    @zips = User.group(:zip).select(:zip)
    @zips = @zips.paginate(:page => 1, :per_page => 9,  conditions:  conditions )

    render :partial=> 'zips_list'

  end




end
