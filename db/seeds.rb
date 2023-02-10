# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create!(username: 'snoop_dogg')
user2 = User.create!(username: 'martha_stewart')
user3 = User.create!(username: 'james-white-rules')
user4 = User.create!(username: 'sean_not_shaun')
user5 = User.create!(username: 'the_burger_king')

Recommendation.create!(recommendee_id: user1.id, recommender_id: user2.id, tmdb_id: 4608, media_type: 'tv')
Recommendation.create!(recommendee_id: user1.id, recommender_id: user3.id, tmdb_id: 4608, media_type: 'tv')
Recommendation.create!(recommendee_id: user1.id, recommender_id: user3.id, tmdb_id: 8592, media_type: 'tv')
Recommendation.create!(recommendee_id: user5.id, recommender_id: user4.id, tmdb_id: 4608, media_type: 'tv')
Recommendation.create!(recommendee_id: user5.id, recommender_id: user4.id, tmdb_id: 274, media_type: 'movie')
