# frozen_string_literal: true

module Types
  class ShowType < Types::BaseObject
    field :tmdbId, Integer, null: false
    field :title, String, null: false
    field :releaseYear, String
    field :streamingService, [Types::StreamingServiceType]
    field :posterUrl, String
    field :genres, [String]
    field :rating, Float
    field :summary, String
    field :mediaType, String
    
    field :recommendedBy, [Types::UserType]

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
