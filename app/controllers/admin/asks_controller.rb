class  Admin::AsksController < Admin::AdminController


    def index
        @asks = Ask.paginate(page: params[:page], per_page:15 )
        if request.content_type == 'text'
          render partial: 'list'
        end
    end

    def new
        @ask = Ask.new
      render partial: 'form'
    end

    def create
      @ask = Ask.new(params[:ask])
      if @ask.save
        render text: 'ok'
      else
        render partial: 'form'
      end
    end

    def edit
      @ask = Ask.find(params[:id])
     render partial: 'form'
    end

    def update
      @ask = Ask.find(params[:id])
      if @ask.update_attributes(params[:ask])
        render text: 'ok'
      else
        render partial: 'form'
      end
    end

    def destroy
      @ask = Ask.find(params[:id])
      @ask.destroy
      render text: 'ok'
    end


end
