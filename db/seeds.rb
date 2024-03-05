# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(username: 'ValB', email: 'valentin.beaussart@gmail.com', password: 'password', password_confirmation: 'password')
User.create!(username: 'Val', email: 'valentin.beaussart@gmail.com', password: 'password', password_confirmation: 'password')

Category.create!(name: 'Véhicules')
Category.create!(name: 'Immobilier')

Ad.create!(name: 'Renault Clio', latin_name: 'Renault Clio', description: 'Voiture en bon état', place: 'Paris',
           price: 1000, category_id: 2, user_id: 1)
Ad.create!(name: 'Peugeot 206', latin_name: 'Peugeot 206', description: 'Voiture en bon état', place: 'Paris',
           price: 1000, category_id: 1, user_id: 2)
Ad.create!(name: 'Appartement', latin_name: 'Appartement', description: 'Appartement en bon état', place: 'Paris',
           price: 1000, category_id: 2, user_id: 1)
