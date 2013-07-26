module PdfWritter
  class TestDocument < Prawn::Document

    def to_pdf_hopper(hopper_id)
      @hopper =User.find_by_id(hopper_id)

      table([
                    ["User name", "#{@hopper.user_name}"],
                    ['User id', "#{@hopper.id}"],
                    ['First name', "#{@hopper.first_name}"],
                    ['Last name', "#{@hopper.last_name}"],
                    ['Email', "#{@hopper.email}"],
                    ['Phone', "#{@hopper.phone}"],
                    ['Contact', "#{@hopper.contact}"],
                    ['Facebook id', "#{@hopper.facebook}"],
                    ['Twitter id', "#{@hopper.twitter}"],
                    ['Google+ id', "#{@hopper.google}"]],
            :column_widths => {0 => 80, 1 => 180},
            :cell_style => { :inline_format => true } )

      move_down(20)
      dice = "#{Rails.root}/public#{@hopper.avatar.url[0...@hopper.avatar.url.index('?')]}"
      image dice, :at => [270, 720], :scale => 0.75


       games = @hopper.games.map do |game|
         [
           game.name

          ]
       end
      games =  @hopper.games

      table([
               ["Hops played", "Hops won"]



          ], :column_widths => {0 => 120, 1 => 120})



      #bounding_box([120,471], :width => 200, :height => 200) do
      #   table([
      #          ["Hops won"]
      #
      #
      #
      #      ],:column_widths => {0 => 120})
      #   end

      render
    end

    def to_pdf_hopper_list(hoppers_id)

      table([['user id', 'first name', 'user name', 'email', 'zip']],
             :column_widths => {0 => 80, 1 => 80, 2 => 80, 3 => 180, 4=> 80 }
      )
          #   :column_widths => {0 => 80, 1 => 180}
     gamers = []
      for i in hoppers_id
        gamers << User.find_by_id(i)
      end
    hoppers = gamers.map do |hopper|

        [
          hopper.id.to_s,
          hopper.first_name,
          hopper.user_name,
          hopper.email,
          hopper.zip.to_s

        ]
     end
      table(hoppers, :column_widths => {0 => 80, 1 => 80, 2 => 80, 3 => 180, 4 => 80 })
     render
    end

    def hop_to_pdf(id)
      @hop = Hop.find_by_id(id)
      @producer = User.find_by_id(@hop.producer_id)

      hop_tasks = @hop.hop_tasks.all.map do |task|
        [
            task.id.to_s,
            task.text,
            User.find_by_id(task.sponsor_id).user_name.to_s,
            task.sponsor_id.to_s,
            task.hop_picture_file_name.to_s,
            task.pts.to_s,
            task.bonus.to_s,
            task.price.to_s,
            task.amt.to_s
        ]
      end
      hop_ads = @hop.ads.all.map do |ad|
        [
         ad.ad_type,
         ad.sponsor_id.to_s,
         ad.hop_ad_picture_file_name.to_s,
         ad.price.to_s,
         ad.amt.to_s
        ]
      end



      draw_text "Hop #{@hop.name}", :at => [220,720], :size => 20,  :inline_format => true

      bounding_box([5,680], :width => 400, :height => 120)  do
        text "Name  #{@hop.name}"
        move_down(5)
        text "Date/Times  #{@hop.time_start}   to  #{@hop.time_end}"
        move_down(5)
        text "Showprod_id        #{@producer.id}"
        move_down(5)
        text "Contact phone     #{@producer.phone}"
        move_down(5)
        text "Swowprod_contact  #{@producer.contact}"
        move_down(5)
        text "Contact email  #{@producer.email}"

      end
      bounding_box([420,680], :width => 200, :height => 200) do
        text "Id                 #{@hop.id}"
        move_down(5)
        text "Hop code     #{@hop.code}"
        move_down(5)
        text "Hop price     #{@hop.price}"
        move_down(5)
      end

      if !hop_tasks.blank?

        text " Hop Items",  :size => 20,  :inline_format => true , :align => :center
        move_down(10)
        table([
          ["Id", 'text for item', 'sponsor', 'spon_id', 'logo','PTS', 'BNS', 'price', 'ATM paid']

            ], :column_widths => {0 => 19, 1 => 250, 2 => 60, 3 => 45, 4 => 35, 5 =>35, 6=>35, 7 =>40, 8 =>40  })
        table( hop_tasks, :column_widths => {0 => 19, 1 => 250, 2 => 60, 3 => 45, 4 => 35, 5 =>35, 6=>35, 7 =>40, 8 =>40})
        move_down(20)
      end

      if !hop_ads.blank?
       text " Hop Ads",  :size => 20,  :inline_format => true , :align => :center

        move_down(10)

        table([['Ad position', 'Advertiser', 'Ad file', 'Price', 'ATM paid'  ]], :column_widths => {0 => 80, 1 => 80, 2 => 80,3 => 65, 4 => 65})
        table(hop_ads, :column_widths => {0 => 80, 1 => 80, 2 => 80,3 => 65, 4 => 65})
      end


        render

    end

  end

end