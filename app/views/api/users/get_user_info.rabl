object :@user

attributes:id, :last_name, :first_name, :user_name, :contact, :bio, :twitter, :facebook, :google

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

node :friendship_status do |user|
    friendship = Friendship.find_by_user_id_and_friend_id(@current_user.id, user.id)
    friendship.status if friendship
end

node :phone do |user|
    user.phone.to_s if user.phone
end


