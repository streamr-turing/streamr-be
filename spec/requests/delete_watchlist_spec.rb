require "rails_helper"

RSpec.describe "DeleteWatchlist", type: :request do 
    it 'deletes an existing watchlist' do 
    user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
    watchlist = Watchlist.create!(user_id: user_1.id, tmdb_id: 10, media_type: 'movie')
    expect(Watchlist.count).to eq(1)
    post '/graphql', params: { query: query(watchlist.id) }
    json = JSON.parse(response.body) 
   
    expect(Watchlist.count).to eq(0)
    end

    it 'returns the deleted watchlist id' do
      user_1 = User.create!(username: 'snoop_dogg', avatar_url: 'https://www.flaticon.com/free-icon/lion_3940415?related_id=3940415&origin=pack')
      watchlist = Watchlist.create!(user_id: user_1.id, tmdb_id: 10, media_type: 'movie')
      expect(Watchlist.count).to eq(1)
      post '/graphql', params: { query: query(watchlist.id) }
      json = JSON.parse(response.body) 
      data = json['data']['deleteWatchlist']
      
      expect(data).to include(       
          'id' => "#{watchlist.id}",
        )
    end

    def query(id)
      <<~GQL
      mutation
       { deleteWatchlist(id: #{id})
        {
        id
        }
       }
     GQL
    end
end