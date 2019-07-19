# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(name: "Admin", email: "admin@5thcolumn.net", password: "admin123", password_confirmation: "admin123", is_admin: true)
user.confirm

User.create(name: "cmullen", email: "cmullen@test.com", password: "test123", password_confirmation: "test123").confirm
