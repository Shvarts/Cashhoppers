## This file should contain all the record creation needed to seed the database with its default values.
## The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
##
## Examples:
##
##   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
##   Mayor.create(name: 'Emanuel', city: cities.first)
#
#puts 'Create roles...'
#
#Role.destroy_all
#[:admin, :user,:sponsor,:producer,:advertiser  ].each do |role|
#  Role.create(:name => role)
#end
###
#User.destroy_all
#admin = User.new(:email => 'admin@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
#                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
#admin.skip_confirmation!
#admin.save
#admin.roles = [Role.find_by_name(:admin)]
##
#
#admin = User.new(:email => 'sponsor@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
#                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
#admin.skip_confirmation!
#admin.save
#admin.roles = [Role.find_by_name(:sponsor)]
#
#admin = User.new(:email => 'advertiser@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
#                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
#admin.skip_confirmation!
#admin.save
#admin.roles = [Role.find_by_name(:advertiser)]
#
#admin = User.new(:email => 'producer@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
#                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
#admin.skip_confirmation!
#admin.save
#admin.roles = [Role.find_by_name(:producer)]
#
#friend = User.new(:email => 'friend@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'friend',
#                  :last_name => 'friend', :zip => 88000, :user_name => 'friend', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
#friend.skip_confirmation!
#friend.save
#friend.roles = [Role.find_by_name(:user)]

#other_user = User.new(:email => 'other_user@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'other_user',
#                  :last_name => 'other_user', :zip => 88000, :user_name => 'other_user', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
#other_user.skip_confirmation!
#other_user.save
#other_user.roles = [Role.find_by_name(:user)]
#
#Friendship.request(admin, friend)
#Friendship.accept(friend, admin)
#
#
#5.times do |t|
#  user = User.new(:email => "admin_#{t}@cashhoppers.com", :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
#                  :last_name => 'CashHoppers', :zip => 8800 + t, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
#  user.skip_confirmation!
#  user.save
#  user.roles = [Role.find_by_name(:admin)]
#end
#
#10.times do |t|
#  user = User.new(:email => "user_#{t}@cashhoppers.com", :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => "user_#{t}",
#                  :last_name => "user_#{t}", :zip => 88000, :user_name => 'user', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png')))
#  user.skip_confirmation!
#  user.save
#  user.roles = [Role.find_by_name(:user)]
#end
#
#
#puts 'Create applications...'
#
#Application.create(:name => 'dev key', :api_key => '123')

#puts 'Create hops...'

##'----------add---ribbits-------------'
##User.all.each do |user|
##
##user.update_attribute :frog_legs, 20000
##end

#users =User.all
#users.each do |i|
#
#  i.update_attributes(:photo=>File.new(Rails.root.join("public/system/user_hop_task_photos/tasks/92/original/PHOTO.jpeg")))  unless File.exist?(Rails.root.join("public/#{i.avatar.url.split('?')[0][1..-1]}"))
#
#
#end
#hops =Hop.all
#hops.each do |i|
#
#  i.update_attributes(:logo=>nil)  unless File.exist?(Rails.root.join("public/#{i.logo.url.split('?')[0][1..-1]}"))
#
#
#end
#hop_tasks =HopTask.all
#hop_tasks.each do |i|
#
#  i.update_attributes(:logo=>nil)  unless File.exist?(Rails.root.join("public/#{i.logo.url.split('?')[0][1..-1]}"))
#
#
#end
#user_tasks =UserHopTask.all
#user_tasks.each do |i|
#
#  i.update_attributes(:photo=>File.new(Rails.root.join("public/system/user_hop_task_photos/tasks/92/original/PHOTO.jpeg")))  unless File.exist?(Rails.root.join("public/#{i.photo.url.split('?')[0][1..-1]}"))
##
##
#end
#ads=Ad.all
#ads.each do |i|
#  puts i.update_attributes(:picture=>File.new(Rails.root.join("app/assets/images/no_ad_picture.png"), 'rb'))  unless File.exist?(Rails.root.join("public/#{i.picture.url.split('?')[0][1..-1]}"))

#end
#users = User.where(:deleted=>['Null', 'null', nil])
#
#users.each do |i|
#  i.update_attributes(:deleted=>false)
#end


#ch_users = ChUsers.all
#
#ch_users.each do |i|
#  password = SecureRandom.base64(n=6)
#  user = User.new(first_name: i.ch_user_firstname, last_name: i.ch_user_lastname, email: i.ch_user_email, user_name: i.ch_user_firstname, zip: 46236, password: password, :password_confirmation => password, string: password )
#
#  user.skip_confirmation!
#  puts "---------------------------------------------------------------"
#  puts user.save
#  user.roles = [Role.find_by_name(:user)]
#end

