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
            [@hop.id,@hop.code, @hop.name,@hop.time_start, @hop.time_end, @hop.price, @hop.jackpot, @hop.event]],
            :column_widths => {0 => 35, 1 => 60, 2 => 70, 3 => 80, 4 => 80, 5 => 60, 6 => 60, 7=> 80  }

      )
      move_down(10)
      table([['Producer id','Producer contact', 'Producer email', 'Producer phone'],
             [@producer.id, @producer.contact, @producer.email, @producer.phone]],
            :column_widths => {0 => 80, 1 => 80, 2 => 180, 3 => 80 }
      )



      render
    end

  end

end