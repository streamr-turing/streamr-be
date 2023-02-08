require "rails_helper"

RSpec.describe "CreateWatchlist", type: :request do 
    it 'creates new watchlist' do 
    user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
    user_2 = User.create!(username: 'martha_stewart', avatar_url: 'https://www.flaticon.com/free-icon/chicken_9306921')
    user_3 = User.create!(username: 'james-white-rules', avatar_url: 'https://www.flaticon.com/free-icon/bear_3940403')
    post '/graphql', params: { query: query(user_1.id) }
    json = JSON.parse(response.body) 
   
     watchlist = Watchlist.last
     expect(watchlist.user_id).to eq(user_1.id)
     expect(watchlist.media_type).to eq('movie')
     expect(watchlist.tmdb_id).to eq(10)
    end

    it 'returns the newly created watchlist details' do
      user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
      user_2 = User.create!(username: 'martha_stewart', avatar_url: 'https://www.flaticon.com/free-icon/chicken_9306921')
      user_3 = User.create!(username: 'james-white-rules', avatar_url: 'https://www.flaticon.com/free-icon/bear_3940403')
      post '/graphql', params: { query: query(user_1.id) }
      json = JSON.parse(response.body) 
      data = json['data']['createWatchlist']
      
      expect(data).to include(       
          'id' => "#{Watchlist.last.id}",
          'userId' => user_1.id,
          'tmdbId' => 10,
          'mediaType' => 'movie',
        )
    end

    def query(user_id)
      <<~GQL
      mutation
       { createWatchlist(tmdbId: 10, userId: #{user_id}, mediaType: "movie" )
        {
        id
        tmdbId
        userId
        mediaType
        }
       }
     GQL
    end
end