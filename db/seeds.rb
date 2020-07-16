5.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "test-taro#{n + 1}",
    password: "test1111"
  )
end