require "rails_helper"

RSpec.describe "CreateWatchlistItem", type: :request do 
    it 'creates new watchlist item' do 
    user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
    user_2 = User.create!(username: 'martha_stewart', avatar_url: 'https://www.flaticon.com/free-icon/chicken_9306921')
    user_3 = User.create!(username: 'james-white-rules', avatar_url: 'https://www.flaticon.com/free-icon/bear_3940403')
    post '/graphql', params: { query: query(user_1.id) }
    json = JSON.parse(response.body) 
   
     watchlist_item = WatchlistItem.last
     expect(watchlist_item.user_id).to eq(user_1.id)
     expect(watchlist_item.media_type).to eq('movie')
     expect(watchlist_item.tmdb_id).to eq(10)
    end

    it 'returns the newly created watchlist item details' do
      user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
      user_2 = User.create!(username: 'martha_stewart', avatar_url: 'https://www.flaticon.com/free-icon/chicken_9306921')
      user_3 = User.create!(username: 'james-white-rules', avatar_url: 'https://www.flaticon.com/free-icon/bear_3940403')
      post '/graphql', params: { query: query(user_1.id) }
      json = JSON.parse(response.body) 
      data = json['data']['createWatchlistItem']
      
      expect(data).to include(       
          'id' => "#{WatchlistItem.last.id}",
          'userId' => user_1.id,
          'tmdbId' => 10,
          'mediaType' => 'movie',
        )
    end

    def query(user_id)
      <<~GQL
      mutation
       { createWatchlistItem(tmdbId: 10, userId: #{user_id}, mediaType: "movie" )
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