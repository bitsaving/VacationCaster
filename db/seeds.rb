# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
u.skip_confirmation!
u.save!



# Test user accounts
(1..5).each do |i|
  u = User.new(
      email: "user#{i}@example.com",
      password: "1234",
      password_confirmation: "1234"
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)

end

Search.create!({
  options: "?guests=4&room_types[]=Entire+home/apt&hosting_amenities[]=4&hosting_amenities[]=8&property_type_id[]=2&sw_lat=38.88914249719223&sw_lng=-120.02562288576348&ne_lat=38.95778948815109&ne_lng=-119.95198015505059&zoom=13&search_by_map=true",
  name: "Family Tahoe Get Away",
  slug: "family-tahoe-get-away",
  start_date: DateTime.new(2014,10,21),
  end_date: DateTime.new(2014,10,30),
  user_id: 1
})

