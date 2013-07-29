object :@ad
attributes :id,
           :ad_type,
           :link,
           :hop_id,
           :advertizer_id
node(:picture) {|ad| ad.picture.url if ad.picture }