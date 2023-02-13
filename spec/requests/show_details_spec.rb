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
      WatchlistItem.create!(user_id: user2.id, tmdb_id: 1400, media_type: 'tv')
      WatchlistItem.create!(user_id: user5.id, tmdb_id: 1400, media_type: 'tv')

      post '/graphql', params: { query: show_details(4608, user1.id, "tv") }
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:showDetails]

      expect(response.status).to eq 200

      expect(data[:tmdbId]).to eq(4608)
      expect(data[:title]).to eq("30 Rock")
      expect(data[:releaseYear]).to eq("2006")
      expect(data[:posterUrl]).to eq("https://image.tmdb.org/t/p/w500/k3RbNzPEPW0cmkfkn1xVCTk3Qde.jpg")
      expect(data[:genres]).to eq(["Comedy"])
      expect(data).to have_key(:rating)
      expect(data[:summary]).to eq("Liz Lemon, the head writer for a late-night TV variety show in New York, tries to juggle all the egos around her while chasing her own dream.")

      expect(data).to have_key(:streamingService)
      expect(data[:streamingService]).to be_an(Array)
      expect(data[:streamingService].size).to eq(2)

      expect(data).to have_key(:recommendedBy)
      expect(data[:recommendedBy]).to be_an(Array)
      expect(data[:recommendedBy].size).to eq(2)
      expect(data[:recommendedBy][0][:id]).to eq("#{user2.id}")
      expect(data[:recommendedBy][1][:id]).to eq("#{user3.id}")
    end
  end

  describe 'unsuccessful requests' do

  end

  def show_details(tmdbId, userId, mediaType)
    <<~GQL
    query {
          showDetails(
              tmdbId: #{tmdbId}
              userId: #{userId}
            	mediaType: "#{mediaType}"
          )
          {
              tmdbId
              title
              releaseYear
              streamingService {
                logoPath
                providerName
              }
              posterUrl
              genres
              rating
              summary
            	mediaType
              recommendedBy {
                      id
                      username
                      avatarUrl
              }
          }
      }
    GQL
  end
end
