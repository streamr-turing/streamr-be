# frozen_string_literal: true

module Types
  class ShowsType < Types::BaseObject
    # field :id, ID, null: false
    field :tmdbId, Integer, null: false
    field :title, String, null: false
    field :imageUrl, String
    field :yearCreated, String
    field :mediaType, String, null: false
    field :genres, [String]
    field :rating, Float
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
