# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

20.times do
    User.create({name: Faker::Name.first_name, 
                user_img: Faker::Avatar.image,
                email: Faker::Internet.email,
                password: "111111" })
end

150.times do
    user = rand(1..20)
    Tweet.create({content: Faker::Lorem.sentence,
                 user_id: user})

end
