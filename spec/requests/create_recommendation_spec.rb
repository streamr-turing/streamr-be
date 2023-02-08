require "rails_helper"

RSpec.describe "CreateRecommendation", type: :request do 
    it 'creates new recommendations' do 
    user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
    user_2 = User.create!(username: 'martha_stewart', avatar_url: 'https://www.flaticon.com/free-icon/chicken_9306921')
    user_3 = User.create!(username: 'james-white-rules', avatar_url: 'https://www.flaticon.com/free-icon/bear_3940403')
    post '/graphql', params: { query: query(user_1.id, user_2.id) }
    json = JSON.parse(response.body) 
   
     rec = Recommendation.last
     expect(rec.recommender_id).to eq(user_1.id)
     expect(rec.recommendee_id).to eq(user_2.id)
     expect(rec.media_type).to eq('movie')
     expect(rec.recommender_id).to_not eq(user_3.id)
    end

    it 'returns the created recommendation' do 
      user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
      user_2 = User.create!(username: 'martha_stewart', avatar_url: 'https://www.flaticon.com/free-icon/chicken_9306921')
      user_3 = User.create!(username: 'james-white-rules', avatar_url: 'https://www.flaticon.com/free-icon/bear_3940403')
      post '/graphql', params: { query: query(user_1.id, user_2.id) }
      json = JSON.parse(response.body)
      data = json['data']['createRecommendation']
   
      expect(data).to include(
       'recommendeeId' => user_2.id,
       'recommenderId' => user_1.id,
       'tmdbId' => 10,
       'mediaType' => "movie"
      )

    end

    def query(recommender_id, recommendee_id)
      <<~GQL
      mutation
       { createRecommendation(tmdbId: 10, recommenderId: #{recommender_id}, recommendeeId: #{recommendee_id}, mediaType: "movie" )
        {
        tmdbId
        recommenderId
        recommendeeId
        mediaType
        }
       }
     GQL
    end
end