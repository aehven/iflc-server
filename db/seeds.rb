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

  Cee.create(name: "Cee #{i+1}", form: 100, source: 100)
end

Cee.all.each do |cee|
  3.times do |i|
    Flavor.create(name: "f#{i+1}_a#{cee.id}",
    color: "l#{i+1}_a#{cee.id}", account: cee)

    Note.create(date: DateTime.now-i.hours, text: "note #{i+1} for cee #{cee.name}", cee: cee)
  end
end

User.all.each do |user|
  3.times do |i|
    user.favorites << Favorite.new(favoritable: Cee.find(i+1))
  end
end
