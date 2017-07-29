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

coffee = Cee.create(name: "Coffee", state: 'liquid', source: 'vegetable')
chocolate = Cee.create(name: "Chocolate", state: 'solid', source: 'vegetable')
cheese = Cee.create(name: "Cheese", state: 'mush', source: 'animal')
cervesa = Cee.create(name: "Cervesa", state: 'liquid', source: 'vegetable')

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
