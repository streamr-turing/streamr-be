module Mutations
  class CreateRecommendation < BaseMutation 
    argument :tmdb_id, ID, required: true
    argument :recommender_id, ID, required: true
    argument :recommendee_id, ID, required: true
    argument :media_type, String, required: true

    type Types::RecommendationType
    def resolve(tmdb_id:, recommender_id:, recommendee_id:, media_type:)
      Recommendation.create!(
        tmdb_id: tmdb_id,
        recommender_id: recommender_id,
        recommendee_id: recommendee_id,
        media_type: media_type
      )
    end
  end
end