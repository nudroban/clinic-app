# frozen_string_literal: true

AdminUser.create!(phone: '0507387960', password: 'password')
categories = %w[dantist therapevt family-doctor lor]
categories.each do |category|
  Category.find_or_create_by(name: category.to_s)
end
2.times do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: "050123456#{i}",
    password: 'password',
    password_confirmation: 'password'
  )
end

Category.all.each do |category|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: "066123456#{category.id}",
    password: 'password',
    password_confirmation: 'password',
    category: category,
    role: 1
  )
end
