collection :@ads
attributes :id,
           :advert_id,
           :advertiser_name,
           :hop_id,
           :contact,
           :phone,
           :email,
           :type_add,
           :price,
           :amd_paid,
           :created_at,
           :updated_at,
           :ad_picture_updated_at
node(:ad_picture_url) {|ad| ad.ad_picture.url }