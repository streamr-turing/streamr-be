module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :users,
    [Types::UserType],
    null: false,
    description: "Return a list of all users"

    field :fetch_user,
    resolver: Queries::FetchUser,
    null: false,
    description: "Return a single user by ID"

    def users
      User.all
    end

    field :show_details,
    resolver: Queries::FetchShowDetails,
    null: false

    # field :recommended_by,
    # [Types::RecommendedByType],
    # null:false do
    #   argument :tmdbId, Integer, required: true
    #   argument :userId, Integer, required: true
    #   argument :mediaType, String, required: true
    # end

    # def recommended_by(tmdbId:, userId:, mediaType:)
    #   recommendations = Recommendation.where(recommendee_id: userId, tmdb_id: tmdbId, media_type: mediaType)
    #   recs = recommendations.map do |recommendation|
    #     User.where(id: recommendation[:recommender_id])
    #   end
    #   recs
    # end

    field :shows,
    [Types::ShowsType],
    null: false do
      argument :query, String, required: true
    end
    def shows(query:)
      SearchFacade.search_results(query)
    end

    field :shows_connection, Types::ShowsType.connection_type, null: false do
      argument :query, String, required: true
    end
    def shows_connection(query:)
      SearchFacade.search_results(query)
    end
  end
end
