require 'rails_helper'

RSpec.describe 'the fetch user request' do 
  describe 'successful request' do 
    it 'returns user information' do 
      user_1 = create(:user)
      user_2 = create(:user)
      rec_1 = Recommendation.create!(recommendee_id: user_1.id, recommender_id: user_2.id, tmdb_id: 8592, media_type: 'tv')

      post '/graphql', params: { query: query(user_1.id) }
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:fetchUser]
      recs = data[:recommendations].first

      expect(response.status).to eq 200

      expect(data).to have_key(:id)
      expect(data).to have_key(:username)
      expect(data).to have_key(:avatarUrl)

      # expect(data).to have_key(:watchlist)

      expect(data).to have_key(:recommendations)
      expect(data[:recommendations]).to be_a Array
      expect(recs).to have_key(:recommendeeId)
      expect(recs).to have_key(:recommender)
      expect(recs[:recommender]).to have_key(:id)
      expect(recs[:recommender]).to have_key(:username)
      expect(recs[:recommender]).to have_key(:avatarUrl)
      # expect(recs).to have_key(:show)
      # expect(recs[:show]).to have_key(:tmdbId)
      expect(recs).to have_key(:createdAt)
    end
  end

  describe 'unsuccessful requests' do 
    it 'returns errors if bad user id provided' do 
      user_1 = create(:user)

      post '/graphql', params: { query: query(user_1.id + 1) }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:errors)
      expect(json[:errors].first).to have_key(:message)
      expect(json[:errors].first[:message]).to eq('Artist does not exist.')
    end

    it 'returns errors if unavailable fields are queried' do 
      user_1 = create(:user)

      post '/graphql', params: { query: bad_query(user_1.id, 'jellybeans') }
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json).to have_key(:errors)
      expect(json[:errors].first).to have_key(:message)
      expect(json[:errors].first[:message]).to eq("Field 'jellybeans' doesn't exist on type 'User'")
    end
  end

  def query(user_id)
    <<~GQL
      query {
        fetchUser(
          id: #{user_id}
        )
        {
          id
          username
          avatarUrl
          # watchlist {
          #     show {
          #         tmdbId
          #         title
          #         releaseYear
          #         thumbnailUrl
          #     }
          # }
          recommendations {
              recommendeeId
              recommender {
                  id
                  username
                  avatarUrl
              }
              # show {
              #     tmdbId
              #     title
              #     releaseYear
              #     rating
              #     genres
              #     thumbnailUrl
              # }
              createdAt
          }
        }
      }
    GQL
  end

  def bad_query(user_id, field)
    <<~GQL
      query {
        fetchUser(
          id: #{user_id}
        )
        {
          id
          #{field}
        }
      }
    GQL
  end
end