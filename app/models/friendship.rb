class Friendship < ActiveRecord::Base

  attr_accessible :accepted_at, :created_at, :friend_id, :status, :string, :user_id, :friend, :user
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  validates_presence_of :user_id, :friend_id

  # Return true if the users are (possibly pending) friends.
  def self.exists?(user, friend)
    not find_by_user_id_and_friend_id(user, friend).nil?
  end

  # Record a pending friend request.
  def self.request(user, friend)
    unless user == friend or Friendship.exists?(user, friend)
      Notification.create(user_id: friend.id, friend_id: user.id, event_type: 'Friend invite')
      transaction do
        create(:user => user, :friend => friend, :status => 'pending')
        create(:user => friend, :friend => user, :status => 'requested')
      end
    end
  end

  # Accept a friend request.
  def self.accept(user, friend)
    Notification.create(user_id: friend.id, friend_id: user.id, event_type: 'Friend invite accept')
    transaction do
      accepted_at = Time.now
      accept_one_side(user, friend, accepted_at)
      accept_one_side(friend, user, accepted_at)
    end
  end

  # Delete a friendship or cancel a pending request.
  def self.breakup(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user, friend))
      destroy(find_by_user_id_and_friend_id(friend, user))
    end
  end

  private

  # Update the db with one side of an accepted friendship request.
  def self.accept_one_side(user, friend, accepted_at)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.accepted_at = accepted_at
    request.save!
  end

end
