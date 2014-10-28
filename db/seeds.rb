puts 'Create roles ...'

Role.destroy_all
[:admin, :user, :sponsor, :producer, :advertiser].each do |role|
  Role.create(:name => role)
end

puts 'Create users ...'

User.destroy_all
admin = User.new(:email => 'admin@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png', deleted: false)))
admin.skip_confirmation!
admin.save
admin.roles = [Role.find_by_name(:admin)]

admin = User.new(:email => 'sponsor@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png', deleted: false)))
admin.skip_confirmation!
admin.save
admin.roles = [Role.find_by_name(:sponsor)]

admin = User.new(:email => 'advertiser@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png', deleted: false)))
admin.skip_confirmation!
admin.save
admin.roles = [Role.find_by_name(:advertiser)]

admin = User.new(:email => 'producer@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin',
                 :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png', deleted: false)))
admin.skip_confirmation!
admin.save
admin.roles = [Role.find_by_name(:producer)]

other_user = User.new(:email => 'other_user@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'other_user',
                  :last_name => 'other_user', :zip => 88000, :user_name => 'other_user', :avatar => File.open(File.join(Rails.root, '/app/assets/images/rails.png', deleted: false)))
other_user.skip_confirmation!
other_user.save
other_user.roles = [Role.find_by_name(:user)]

puts 'Create applications ...'

Application.create(:name => 'dev key', :api_key => '123')

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




