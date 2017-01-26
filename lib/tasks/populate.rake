namespace :fill do
  desc 'Fill data'
  task data: :environment do
    require 'faker'
    require 'populator'
    puts 'Erasing existing data'
    puts '====================='

    [User, Event, Comment].each(&:delete_all)
    PublicActivity::Activity.delete_all

    puts 'Creating users'
    puts '=============='
    password = 'socify'


    User.populate 100 do |user|
      user.name = Faker::Name.name
      user.email = Faker::Internet.email
      user.provider = user.email
      user.uid = user.email
      user.encrypted_password = User.new(password: password).encrypted_password
      user.confirmed_at = DateTime.now
      user.sign_in_count = 0
      puts "created user #{user.name}"
    end


    user = User.new(name: 'Rails', email: 'test@example.com', password: 'password')
    user.save!
    puts 'Created test user with email=test@example.com and password=password'

    puts 'Generate Friendly id slug for users'
    puts '==================================='
    User.find_each(&:save)

    users = User.all

    events = Event.all
    puts 'Creating Events'
    puts '==============='

    1500.times do
      event = Event.new
      event.name = Populator.words(1..3).titleize
      event.when = Faker::Date.between(2.years.ago, 1.day.from_now)
      event.place = Populator.words(1..2).titleize
      event.purpose = Populator.words(1..3).titleize
      event.user_id = Faker::Number.between(1, 100)
      event.save
      puts "created event #{event.name}"
    end




  end
end
