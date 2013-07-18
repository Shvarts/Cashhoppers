object false

node :pending_friends do
  @pending_friends.map { |friend| friend.id }
end