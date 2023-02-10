module Queries
  class FetchShowDetails < Queries::BaseQuery
    type Types::ShowType, null: false
    argument :tmdbId, Integer
    argument :userId, Integer
    argument :mediaType, String

    def resolve(tmdbId:, userId:, mediaType:)
      show_details = ShowDetailFacade.show_details(mediaType, tmdbId)

      recommendations = Recommendation.where(recommendee_id: userId, tmdb_id: tmdbId, media_type: mediaType)
      recs = recommendations.map do |recommendation|
        User.where(id: recommendation[:recommender_id])
      end.flatten

      show_details.recommended_by(recs)
      show_details
    end
  end
end
