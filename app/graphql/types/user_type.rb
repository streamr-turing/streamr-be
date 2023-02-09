# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String
    field :avatar_url, String
    field :watchlists, [Types::WatchlistType], null: false
    field :recommendations, [Types::RecommendationType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def recommendations
      object.received_recommendations
    end
  end
end
