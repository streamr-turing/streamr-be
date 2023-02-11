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

Recommendation.create!(recommendee_id: user1.id, recommender_id: user2.id, tmdb_id: 4608, media_type: 'tv', created_at: Time.zone.now)
Recommendation.create!(recommendee_id: user1.id, recommender_id: user3.id, tmdb_id: 4608, media_type: 'tv', created_at: Time.zone.now + 1.minute, updated_at: Time.zone.now + 1.minute)
Recommendation.create!(recommendee_id: user1.id, recommender_id: user3.id, tmdb_id: 8592, media_type: 'tv', created_at: Time.zone.now + 2.minutes, updated_at: Time.zone.now + 2.minute)
Recommendation.create!(recommendee_id: user1.id, recommender_id: user4.id, tmdb_id: 197, media_type: 'movie', created_at: Time.zone.now + 3.minutes, updated_at: Time.zone.now + 3.minute)
Recommendation.create!(recommendee_id: user5.id, recommender_id: user4.id, tmdb_id: 4608, media_type: 'tv', created_at: Time.zone.now + 4.minutes, updated_at: Time.zone.now + 4.minute)
Recommendation.create!(recommendee_id: user5.id, recommender_id: user4.id, tmdb_id: 274, media_type: 'movie', created_at: Time.zone.now + 5.minutes, updated_at: Time.zone.now + 5.minute)

WatchlistItem.create!(user_id: user1.id, tmdb_id: 1400, media_type: 'tv')
WatchlistItem.create!(user_id: user1.id, tmdb_id: 4608, media_type: 'tv')
WatchlistItem.create!(user_id: user1.id, tmdb_id: 8592, media_type: 'tv')
WatchlistItem.create!(user_id: user1.id, tmdb_id: 8469, media_type: 'movie')
WatchlistItem.create!(user_id: user2.id, tmdb_id: 1400, media_type: 'tv')
WatchlistItem.create!(user_id: user3.id, tmdb_id: 1400, media_type: 'tv')