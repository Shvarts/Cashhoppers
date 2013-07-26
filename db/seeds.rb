# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

60.times do |t|
  hop = Hop.create(close: false, event: 'new year', daily: false, code: 'ewre', price: 12, jackpot: 34, name: 'hop #1', producer_id: admin.id, time_end: Time.now, time_start: Time.now)

end

5.times do |t|
  user = User.new(:email => "admin_#{t}@cashhoppers.com", :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
                  :last_name => 'CashHoppers', :zip => 8800 + t, :user_name => 'admin',
                  :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
  user.skip_confirmation!
  user.save
  user.roles = [Role.find_by_name(:admin)]
end

60.times do |t|
  user = User.new(:email => "user_#{t}@cashhoppers.com", :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => "user_#{t}",
                  :last_name => "user_#{t}", :zip => 88000, :user_name => 'user',
                  :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
  user.skip_confirmation!
  user.save
  user.roles = [Role.find_by_name(:user)]
end

Application.create(:name => 'dev key', :api_key => '123')
