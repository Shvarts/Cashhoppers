# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Create roles...'

Role.destroy_all
[:admin, :user].each do |role|
  Role.create(:name => role)
end

User.destroy_all
admin = User.new(:email => 'admin@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin',
                 :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
admin.skip_confirmation!
admin.save
admin.roles = [Role.find_by_name(:admin)]

friend = User.new(:email => 'friend@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'friend',
                  :last_name => 'friend', :zip => 88000, :user_name => 'friend',
                  :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
friend.skip_confirmation!
friend.save
friend.roles = [Role.find_by_name(:user)]

other_user = User.new(:email => 'other_user@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'other_user',
                  :last_name => 'other_user', :zip => 88000, :user_name => 'other_user',
                  :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
other_user.skip_confirmation!
other_user.save
other_user.roles = [Role.find_by_name(:user)]

Friendship.request(admin, friend)
Friendship.accept(friend, admin)

5.times do |t|
  user = User.new(:email => "admin_#{t}@cashhoppers.com", :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
                  :last_name => 'CashHoppers', :zip => 8800 + t, :user_name => 'admin',
                  :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
  user.skip_confirmation!
  user.save
  user.roles = [Role.find_by_name(:admin)]
end

10.times do |t|
  user = User.new(:email => "user_#{t}@cashhoppers.com", :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => "user_#{t}",
                  :last_name => "user_#{t}", :zip => 88000, :user_name => 'user',
                  :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
  user.skip_confirmation!
  user.save
  user.roles = [Role.find_by_name(:user)]
end

puts 'Create applications...'

Application.create(:name => 'dev key', :api_key => '123')

puts 'Create hops...'

20.times do |i|
  hop_name = "Hop ##{i}"
  hop = Hop.create( name: hop_name, time_start: Time.now, time_end: Time.now + 1.month, producer_id: 2, code: 123, price: 10,
                    jackpot: 10, daily: false, close: false, event: 'new year', logo: File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
  10.times do |j|
    hop_task_name = "Hop task ##{j} for hop #{hop_name}"
    hop_task = HopTask.create(text: 'Take your picture with DEREVO!!!', sponsor_id: admin.id, price: 10, pts: 15, bonus: 30, amt_paid: 10)
    hop.hop_tasks << hop_task
  end
end
