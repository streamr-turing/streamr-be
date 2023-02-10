require 'rails_helper'

RSpec.describe 'show search request' do
  describe 'successful request', :vcr do
    it 'returns show search results' do
      post '/graphql', params: { query: query('Avatar') }
      json = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry
      data = json[:data][:shows]
      sample = data[0]

      expect(response.status).to eq 200

      expect(sample).to have_key(:tmdbId)
      expect(sample).to have_key(:title)
      expect(sample).to have_key(:imageUrl)
      expect(sample).to have_key(:yearCreated)
      expect(sample).to have_key(:mediaType)
    end
    it 'can return show search results with pagination using a connection' do
      post '/graphql', params: { query: query_connection('Avatar', 5) }
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:showsConnection]

      expect(data).to have_key(:pageInfo)
      expect(data).to have_key(:edges)

      pageInfo = data[:pageInfo]
      edges = data[:edges]

      expect(pageInfo).to have_key(:endCursor)
      expect(pageInfo).to have_key(:startCursor)
      expect(pageInfo).to have_key(:hasPreviousPage)
      expect(pageInfo).to have_key(:hasNextPage)

      expect(edges).to be_an Array
      expect(edges[0]).to have_key(:cursor)
      expect(edges[0]).to have_key(:node)

      sample = edges[0][:node]

      expect(sample).to have_key(:tmdbId)
      expect(sample).to have_key(:title)
      expect(sample).to have_key(:imageUrl)
      expect(sample).to have_key(:yearCreated)
      expect(sample).to have_key(:mediaType)
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

  def query(query)
    <<~GQL
      query {
        shows(
          query: "#{query}"
        )
        {
          tmdbId
          title
          imageUrl
          yearCreated
          mediaType
        }
      }
    GQL
  end

  def query_connection(query, num_results)
    <<~GQL
      query {
        showsConnection(
          query: "#{query}",
          first: #{num_results}
        )
        {
          pageInfo {
            endCursor
            startCursor
            hasPreviousPage
            hasNextPage
          }
          edges {
            cursor
            node {
              tmdbId
              title
              imageUrl
              yearCreated
              mediaType
            }
          }
        }
      }
    GQL
  end
end
