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

end

coffee = Cee.create(name: "Coffee", state: 'liquid', vegetable: true)
chocolate = Cee.create(name: "Chocolate", state: 'solid', vegetable: true, animal: true)
cheese = Cee.create(name: "Cheese", state: 'mush', animal: true)
cervesa = Cee.create(name: "Cervesa", state: 'liquid', vegetable: true)
cake = Cee.create(name: "Cake", state: 'solid', animal: true, vegetable: true, mineral: true)
cookies = Cee.create(name: "Cookies", state: 'solid', animal: true, vegetable: true, mineral: true)

coffee.flavors << Flavor.create(name: 'Dark Roast', color: 'Brown')
coffee.flavors << Flavor.create(name: 'Medium Roast', color: 'Light Brown')

chocolate.flavors << Flavor.create(name: 'Dark', color: 'Brown')
chocolate.flavors << Flavor.create(name: 'Milik', color: 'Light Brown')

cheese.flavors << Flavor.create(name: 'Cream', color: 'White')
cheese.flavors << Flavor.create(name: 'Brie', color: 'White')
cheese.flavors << Flavor.create(name: 'Port', color: 'Cream')

cervesa.flavors << Flavor.create(name: 'Stout', color: 'Black')
cervesa.flavors << Flavor.create(name: 'English Bitter', color: 'Tan')
cervesa.flavors << Flavor.create(name: 'Lager', color: 'Light Brown')

cake.flavors << Flavor.create(name: 'Chocolate', color: 'Brown')
cake.flavors << Flavor.create(name: 'Lemon', color: 'Yellow')
cake.flavors << Flavor.create(name: 'Vanilla', color: 'White')

cookies.flavors << Flavor.create(name: 'Chocolate Chip', color: 'Brown')
cookies.flavors << Flavor.create(name: 'Lemon', color: 'Yellow')
cookies.flavors << Flavor.create(name: 'Sugar', color: 'White')

Cee.all.each do |cee|
  3.times do |i|
    Note.create(date: DateTime.now-i.hours, text: "note #{i+1} for #{cee.name}", cee: cee)
  end
end

User.all.each do |user|
  3.times do |i|
    user.favorites << Favorite.new(favoritable: Cee.find(i+1))
  end
end
