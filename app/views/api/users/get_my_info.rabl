object :@user

attributes:id, :last_name, :first_name, :user_name, :contact, :bio, :twitter, :facebook, :google, :email

node :zip do |user|
   user.zip.to_s
end

node :role do |user|
	user.roles.first.name
end

node :avatar do |user|
    user.avatar.url
end

node :friends_count do |user|
    user.friends.count
end

node :ad_enable do |user|
    user.user_settings.ad_enable if user.user_settings
end

node :phone do |user|
    user.phone.to_s if user.phone
end


