# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# story = FactoryBot.build(:story)
articles = FactoryBot.create_list(:article, 5)

FactoryBot.create(:story, articles: articles.first(3))
