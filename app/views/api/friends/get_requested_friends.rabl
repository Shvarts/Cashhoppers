object false

node :requested_friends do
  @requested_friends.map { |friend| friend.id }
end