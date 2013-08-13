class  Admin::AsksController < Admin::AdminController

   def index
    @asks = Ask.all
    @ask = Ask.new

  end

   def show
    @ask = Ask.find_by_id(params[:id])
  end

 def new
    @ask = Ask.new
    #render :text =>params
 end

  def edit
    @ask = Ask.find(params[:id])
  end

  def create
    @ask = Ask.new(params[:ask])

      if @ask.save
        redirect_to admin_asks_path, notice: 'Ask was successfully created.'
     else
        render action: "new"
      end

  end

  def update
    @ask = Ask.find(params[:id])

      if @ask.update_attributes(params[:ask])
        redirect_to admin_asks_path, notice: 'Ask was successfully updated.'
      else
         render action: "edit"
      end

  end

  def destroy
    @ask = Ask.find(params[:id])
    @ask.destroy

      redirect_to admin_asks_url
  end

end
