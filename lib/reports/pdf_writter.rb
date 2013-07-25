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





    end

  end

end