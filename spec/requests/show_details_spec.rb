require 'rails_helper'

RSpec.describe 'show details request' do
  describe 'successful request', :vcr do
    it 'returns show details' do
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
      WatchlistItem.create!(user_id: user5.id, tmdb_id: 1400, media_type: 'tv')

      post '/graphql', params: { query: fetch_user(user5.id) }
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:fetchUser]
      # require "pry"; binding.pry

      expect(response.status).to eq 200

      expect(data[:id]).to eq("#{user5.id}")
      expect(data[:username]).to eq('the_burger_king')
      expect(data[:avatarUrl]).to eq(user5.avatar_url)

      expect(data).to have_key(:watchlistItems)
      expect(data[:watchlistItems]).to be_an(Array)
      expect(data[:watchlistItems].size).to eq(1)

      expect(data).to have_key(:recommendations)
      expect(data[:recommendations]).to be_an(Array)
      expect(data[:recommendations].size).to eq(2)
      expect(data[:recommendations][0][:recommender][:id]).to eq("#{user4.id}")
      expect(data[:recommendations][0][:show][:tmdbId]).to eq(4608)
    end
  end

  describe 'unsuccessful requests' do
    # it 'returns errors if unavailable fields are queried' do
    #   user_1 = create(:user)
    #
    #   post '/graphql', params: { query: bad_query(user_1.id, 'jellybeans') }
    #   json = JSON.parse(response.body, symbolize_names: true)
    #
    #   expect(json).to have_key(:errors)
    #   expect(json[:errors].first).to have_key(:message)
    #   expect(json[:errors].first[:message]).to eq("Field 'jellybeans' doesn't exist on type 'User'")
    # end
  end

  def fetch_user(id)
    <<~GQL
    query {
      fetchUser (
        id: #{id}
        )
        {
          id
          username
          avatarUrl
          watchlistItems {
            show {
              tmdbId
              title
              releaseYear
              posterUrl
              mediaType
            }
          }
          recommendations {
            recommendeeId
            recommender {
              id
              username
              avatarUrl
            }
            show {
              tmdbId
              title
              releaseYear
              rating
              genres
              posterUrl
              mediaType
            }
            createdAt
          }
        }
      }
    GQL
  end
end
