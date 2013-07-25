object :@user

attributes:id, :last_name, :first_name, :user_name, :zip, :contact, :phone, :bio, :twitter, :facebook, :google

node :role do |user|
	user.roles.first.name
end

node :avatar do |user|
    user.avatar.url if user.avatar_file_size
end

node :friends_count do |user|
    user.friends.count
end


