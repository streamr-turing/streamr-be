# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    # field :id, ID, null: false
    field :username, String
    field :avatar_url, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # field :tmdbId, Integer
    # field :title, String, null: false
    # field :imageUrl, String
    # field :yearCreated, String
    # field :mediaType, String, null: false

  end
end
