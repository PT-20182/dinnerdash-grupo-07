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
MealCategory.create(name: 'Prato principal')
MealCategory.create(name: 'Sobremesa')

a = Meal.create(
    name:"Maçã", 
    description: "Uma maçã muito deliciosa", 
    available: true,

    price: 8.00
)
puts "MEAL criada com id: #{a.id}"
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

user = User.create(
    email:      'joao@dinnerdash',
    name:       'João',
    is_admin:   false,
    password:   'dinnerdash',
    password_confirmation: 'dinnerdash'
)

b = Order.create(
    price: 15.00,
    user_id: user.id,
    situation_id: 1
)

OrderMeal.create(
    quantity: 45,
    order_id: b.id,
    meal_id: a.id,
)

Situation.create(
    description: "Pendente"
)

Situation.create(
    description: "Entregue"
)

Situation.create(
    description: "Cancelado"
)


# Somente para testes
user = User.new(
    email:      'owner@dinnerdash',
    name:       'Owner',
    is_admin:   true,
    password:   'dinnerdash',
    password_confirmation: 'dinnerdash'
)
user.save

user = User.new(
    email:      'joao@dinnerdash',
    name:       'João',
    is_admin:   false,
    password:   'dinnerdash',
    password_confirmation: 'dinnerdash'
)
user.save


