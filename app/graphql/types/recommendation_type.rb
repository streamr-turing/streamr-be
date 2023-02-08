
module Types
  class RecommendationType < Types::BaseObject
    field :id, ID, null: false
    field :recommendee_id, Integer
    field :recommender_id, Integer
    field :tmdb_id, Integer
    field :media_type, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
