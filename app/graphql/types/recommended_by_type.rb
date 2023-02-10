module Types
  class RecommendedByType < Types::BaseObject
    field :userId, Integer, null: false
    field :username, String
    field :avatarUrl, String

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
