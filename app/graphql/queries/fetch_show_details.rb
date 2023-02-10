module Queries
  class FetchShowDetails < Queries::BaseQuery
    type Types::ShowType, null: false
    # type Types::UserType, null: false
    # field :recommendedBy, [Types::RecommendedByType]
    argument :tmdbId, Integer
    argument :userId, Integer
    argument :mediaType, String

    def resolve(tmdbId:, userId:, mediaType:)
      show_details = ShowDetailFacade.show_details(mediaType, tmdbId)
      recommendations = Recommendation.where(recommendee_id: userId, tmdb_id: tmdbId, media_type: mediaType)
      recs = recommendations.map do |recommendation|
        User.where(id: recommendation[:recommender_id])
      end
      # require "pry"; binding.pry
      show_details.recommended_by(recs)
      show_details
    # rescue ActiveRecord::RecordNotFound => _e
    #   GraphQL::ExecutionError.new('Artist does not exist.')
    # rescue ActiveRecord::RecordInvalid => e
    #   GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
    #     " #{e.record.errors.full_messages.join(', ')}")
    end
    # def recommended_by(tmdbId:, userId:, mediaType:)
    #   recommendations = Recommendation.where(recommendee_id: userId, tmdb_id: tmdbId, media_type: mediaType)
    #   recs = recommendations.map do |recommendation|
    #     User.where(id: recommendation[:recommender_id])
    #   end
    #   recs
    # end
  end
end
