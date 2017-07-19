5.times do |i|
  User.create(email: "r#{i}@null.com",
              first_name: "rf#{i}",
              last_name: "rl#{i}",
              password: "password",
              role: "regular"
              )

  User.create(email: "a#{i}@null.com",
              first_name: "af#{i}",
              last_name: "al#{i}",
              password: "password",
              role: "admin"
              )

  Account.create(name: "Account #{i+1}", street: "40#{i+1} Jackson St", city: "Golden", zip: 80403, phone: "303-763-000#{i+1}", kind: "Pediatrician")
end

Account.all.each do |account|
  3.times do |i|
    Contact.create(first_name: "f#{i+1}_a#{account.id}",
    last_name: "l#{i+1}_a#{account.id}", account: account)

    Activity.create(date: DateTime.now-i.hours, text: "activity #{i+1} for account #{account.name}", account: account)
  end
end

User.all.each do |user|
  3.times do |i|
    user.favorites << Favorite.new(favoritable: Account.find(i+1))
  end
end
