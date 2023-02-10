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

    # field :recommendedBy,
    # [Types::RecommendedByType],
    # null:false do
    #   argument :tmdbId, Integer, required: true
    #   argument :userId, Integer, required: true
    #   argument :mediaType, String, required: true
    # end

    field :recommendedBy, [Types::UserType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # def recommendedBy(tmdbId:, userId:, mediaType:)
    #   require "pry"; binding.pry
    #   recommendations = Recommendation.where(recommendee_id: userId, tmdb_id: tmdbId, media_type: mediaType)
    #   recs = recommendations.map do |recommendation|
    #     User.where(id: recommendation[:recommender_id])
    #   end
    #   require "pry"; binding.pry
    #   recs
    # end
  end
end
