# # frozen_string_literal: true
#
# module Types
#   class ShowType < Types::BaseObject
#     field :tmdbId, Integer, null: false
#     field :title, String, null: false
#     field :releaseYear, String
#     field :streamingService, Hash
#     field :posterUrl, String
#     field :genres, Array
#     field :rating, Float
#     field :recommendedBy, [Types::RecommendedByType], null: false
#     field :created_at, GraphQL::Types::ISO8601DateTime, null: false
#     field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
#
#     def recommendedBy
#       Recommendation.where(recommendee_id: userId, tmdb_id: tmdbId, media_type: mediaType)
#     end
#   end
# end
