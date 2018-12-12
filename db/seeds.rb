# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


MealCategory.create(name: 'Massa')
MealCategory.create(name: 'Salada')
MealCategory.create(name: 'Entrada')
MealCategory.create(name: 'Parto principal')
MealCategory.create(name: 'Sobremesa')

Meal.create(
    name:"Maçã", 
    description: "Uma maçã muito deliciosa", 
    available: true,
    price: 8.00
)
Meal.create(
    name:"Banana", 
    description: "A preferida dos macacos",
    available: true,
    price: 4.00
)
Meal.create(
    name:"Abacate", 
    description: "Faz uma vitamina deliciosa",
    available: true,
    price: 10.00
)
Meal.create(
    name:"Abacaxi", 
    description: "A fruta da realeza", 
    available: true,
    price: 15.00
    
)


User.create(name: "Brinquedo", email: "brinquedo@email.com", password: "123456", is_admin: false)
User.create(name: "Epaminondas", email: "epaminondas@email.com", password: "123456", is_admin: true)