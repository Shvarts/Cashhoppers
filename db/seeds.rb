# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.where(:email => 'admin@cashhoppers.com').first
if admin
  admin.destroy
end

Role.destroy_all

Role.create(:name => :admin)
Role.create(:name => :user)
admin = User.new(:email => 'admin@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin', :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin')
admin.skip_confirmation!
admin.save
admin.roles = [Role.find_by_name(:admin)]
