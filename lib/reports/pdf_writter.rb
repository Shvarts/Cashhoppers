module PdfWritter
  class TestDocument < Prawn::Document

    def to_pdf_hopper(hopper_id)
      @hopper =User.find_by_id(hopper_id)
      text "Hopper", :size => 16, :align => :center
      move_down(20)
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
                    ['Google+ id', "#{@hopper.google}"],
                    ['Player since', "#{@hopper.created_at}"]
            ],
            :column_widths => {0 => 80, 1 => 180},
            :cell_style => { :inline_format => true } )

        move_down(20)
        text 'Avatar'
        move_down(10)
          begin
            dice = ''
            if @hopper.avatar_file_size
              dice = "#{@hopper.avatar.path}"
            else
              dice = "#{Rails.root}/app/assets/images/no_avatar.png"
            end
          #
          #rescue Exception =>e
          #  dice = "#{Rails.root}/public#{@hopper.avatar.url}"
         end
          image dice,  :scale => 0.75
          games = @hopper.games.map do |game|
         [
           game.name

          ]
       end
       bounding_box([340,680], :width => 200, :height => 200) do
         table([
                ["Hops played"]
            ],:column_widths => {0 => 100})

         unless @hopper.games.blank?
            games = @hopper.games.map do |i|
              [
                  i.name
              ]
            end
            table(games, :column_widths => {0 => 100})

         end

         end
      bounding_box([440,680], :width => 200, :height => 200) do
         table([
                ["Hops won"]
            ],:column_widths => {0 => 100})

         unless @hopper.prizes.blank?
            prizes = @hopper.prizes.map do |i|
              [
                  Hop.find_by_id(i.hop_id).name
              ]
            end
            table(prizes, :column_widths => {0 => 100})

         end

      end

      render
    end

    def to_pdf_hopper_list(hoppers_id)
      text "Hoppers list", :size => 16, :align => :center
      move_down(20)
      table([['user id', 'first name', 'user name', 'email', 'zip']],
             :column_widths => {0 => 80, 1 => 80, 2 => 80, 3 => 180, 4=> 80 }
      )
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

    def print_hop_pdf(hop_id)
      @hop = Hop.find_by_id(hop_id)
      @producer = User.find_by_id(@hop.producer_id)
      text "Hop", :size => 16, :align => :center
      move_down(5)
      table([['Id','Hop code', 'Hop name', 'time start', 'time end', 'price', 'jackpot', 'Special event'],
             [@hop.id,@hop.code, @hop.name,@hop.time_start.to_s, @hop.time_end.to_s, @hop.price, @hop.jackpot, @hop.event]],
            :column_widths => {0 => 35, 1 => 60, 2 => 70, 3 => 80, 4 => 80, 5 => 60, 6 => 60, 7=> 80  }

      )
      move_down(10)
      if  @producer
        table([['Producer id','Producer contact', 'Producer email', 'Producer phone'],
               [@producer.id, @producer.contact, @producer.email, @producer.phone]],
              :column_widths => {0 => 80, 1 => 80, 2 => 180, 3 => 80 }
        )
      end

      unless @hop.prizes.blank?
        move_down(10)
        text "Prizes", :size => 16, :align => :center
        move_down(10)
        prizes = @hop.prizes.map do |i|
          [
              i.place,
              i.cost
          ]

        end
        table([['Place', 'Prize']],
              :column_widths => {0 => 60, 1 => 80})
        table(prizes, :column_widths => {0 => 60, 1 => 80 })

      end


      move_down(10)
      text "Hop item", :size => 16, :align => :center
      move_down(10)
      items = @hop.hop_tasks.all.map do |task|
        [
            task.id,
            task.text,
            User.find_by_id(task.sponsor_id).first_name,
            task.sponsor_id,
            task.pts,
            task.bonus,
            task.price,
            task.amt_paid

        ]

      end
      if !items.blank?
        table([['id', 'text for hop item', 'sponsor', 'sponsor_id', 'PTS', "BNS", 'Price', "AMT paid"]],
              :column_widths => {0 => 20, 1 => 180, 2 => 60, 3 => 30, 4  => 60, 5  => 60, 6  => 60, 7  => 60 })
        table(items, :column_widths => {0 => 20, 1 => 180, 2 => 60, 3 => 30,  4  => 60, 5  => 60, 6  => 60, 7  => 60 })
      end
      move_down(10)
      text "Hop ad", :size => 16, :align => :center
      move_down(10)

      if !@hop.ads.blank?

         ads = @hop.ads.all.map do |ad|
          [
            ad.ad_type,
            User.find_by_id(ad.advertizer_id).first_name,
            ad.picture_file_name,
            ad.price,
            ad.amt_paid
          ]
        end

        table([['Position', 'Advertizer', 'Logo', 'Price', "AMT paid"]],
              :column_widths => {0 => 60, 1 => 180, 2 =>90, 3 => 70, 4  => 70})
        table(ads, :column_widths => {0 => 60, 1 => 180, 2 =>90, 3 => 70,  4  => 70 })
      end
     render
    end

    def hops_to_pdf(id)
      if id.first.close == false
        text "Current hops", :size => 16, :align => :center
      else
        text "Archived hops", :size => 16, :align => :center
      end
      move_down(10)
      hops =id.map do |hop|
        [
            hop.id,
            hop.name,
            hop.time_start.to_s,
            hop.time_end.to_s,
            hop.hoppers.count,
            hop.hop_tasks.count,
            hop.ads.count
        ]

      end

      if !hops.blank?
        table([['Id', 'Name', 'Time start', 'Time end', "Hoppers", 'Items', 'Ads']],
              :column_widths => {0 => 40, 1 => 80, 2 =>90, 3 => 70, 4  => 40, 5  => 40, 6  => 40})
        table(hops, :column_widths => {0 => 40, 1 => 80, 2 =>90, 3 => 70, 4  => 40, 5  => 40, 6  => 40})
      end
      render
    end


  end

end