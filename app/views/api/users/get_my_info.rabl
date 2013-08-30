object :@user

attributes:id, :last_name, :first_name, :user_name, :zip, :contact, :bio, :twitter, :facebook, :google, :email, :phone

node :role do |user|
	user.roles.first.name
end

node :avatar do |user|
    user.avatar.url if user.avatar_file_size
end

node :friends_count do |user|
    user.friends.count
end

node :ad_enable do |user|
    user.user_settings.ad_enable if user.user_settings
end


