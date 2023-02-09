require "rails_helper"

RSpec.describe "DeleteWatchlistItem", type: :request do 
    it 'deletes an existing watchlist item' do 
    user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
    watchlist_item = WatchlistItem.create!(user_id: user_1.id, tmdb_id: 10, media_type: 'movie')
    expect(WatchlistItem.count).to eq(1)
    post '/graphql', params: { query: query(watchlist_item.id) }
    json = JSON.parse(response.body) 
   
    expect(WatchlistItem.count).to eq(0)
    end

    it 'returns the deleted watchlist item id' do
      user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
      watchlist_item = WatchlistItem.create!(user_id: user_1.id, tmdb_id: 10, media_type: 'movie')
      expect(WatchlistItem.count).to eq(1)
      post '/graphql', params: { query: query(watchlist_item.id) }
      json = JSON.parse(response.body) 
      data = json['data']['deleteWatchlistItem']
      
      expect(data).to include(       
          'id' => "#{watchlist_item.id}",
        )
    end

    def query(id)
      <<~GQL
      mutation
       { deleteWatchlistItem(id: #{id})
        {
        id
        }
       }
     GQL
    end
end