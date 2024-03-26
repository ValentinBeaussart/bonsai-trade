# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(username: 'Valentin', email: 'elboboss@hotmail.fr', password: 'password', password_confirmation: 'password')

Category.create!(name: 'Bonsaï')
Category.create!(name: 'Prébonsaï')
Category.create!(name: 'Yamadori')
Category.create!(name: 'Plant de pépinière')
Category.create!(name: 'Pot rond')
Category.create!(name: 'Pot rectangulaire')
Category.create!(name: 'Pot spéciaux')
Category.create!(name: 'Pot mame')
Category.create!(name: 'Coupe')
Category.create!(name: 'Ligaturage')
Category.create!(name: 'Rempotage')
Category.create!(name: 'Arrosage')
