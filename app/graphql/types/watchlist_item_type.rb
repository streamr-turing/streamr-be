module Types
  class WatchlistItemType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :tmdb_id, Integer, null: false
    field :media_type, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end