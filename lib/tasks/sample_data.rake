namespace :db do
  desc "Fill in DB with sample data"
  task populate: :environment do
  	make_users
    make_tweets
    make_relationships
  end
end

def make_users
  User.create!( name: 'blackjack94',
                email: 'letadangkhoa@gmail.com',
                password: '123456',
                password_confirmation: '123456',
                admin: true )
  40.times do |n|
    name = Faker::Name.name
    email = "user-#{n}@gmail.com"
    password = "password"
    User.create!( name: name, 
                  email: email,
                  password: password,
                  password_confirmation: password )
  end
end

def make_tweets
  users = User.all(limit: 6)
  30.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.tweets.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first

  followed_users = users[2..30]
  followers      = users[3..30]

  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end