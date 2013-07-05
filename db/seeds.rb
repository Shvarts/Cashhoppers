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

User.destroy_all(:email => 'admin@cashhoppers.com')
admin = User.new(:email => 'admin@cashhoppers.com', :password => 'qwerty11', :password_confirmation => 'qwerty11', :first_name => 'admin', :last_name => 'CashHoppers', :zip => 88000, :user_name => 'admin')
admin.skip_confirmation!
admin.save
admin.roles = [Role.find_by_name(:admin)]

Application.create(:name => 'dev key', :api_key => '123')
