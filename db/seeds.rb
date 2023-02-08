# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
user2 = User.create!(username: 'martha_stewart', avatar_url: 'https://www.flaticon.com/free-icon/chicken_9306921')
user3 = User.create!(username: 'james-white-rules', avatar_url: 'https://www.flaticon.com/free-icon/bear_3940403')

Recommendation.create!(recommendee_id: user1.id, recommender_id: user2.id, tmdb_id: 4608, media_type: 'tv')
Recommendation.create!(recommendee_id: user1.id, recommender_id: user3.id, tmdb_id: 8592, media_type: 'tv')