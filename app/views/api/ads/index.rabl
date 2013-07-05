collection :@ads
attributes :id,
           :ad_name,
           :ad_type,
           :link_to_ad,
           :hop_id,
           :created_at,
           :updated_at,
           :hop_ad_picture_updated_at
node(:ad_picture_url) {|ad| ad.hop_ad_picture.url }