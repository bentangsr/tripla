puts "Seeding 10 users"
10.times do |n|
  User.create(name: Faker::Name.unique.name)
end

puts "Seeding 24 hours of clock_operations"
24.times do |n|
  ClockOperation.create(clock_at: "#{n.to_s}:00")
end