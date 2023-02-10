module Types
  class RecommendationType < Types::BaseObject
    field :id, ID, null: false
    field :recommendee_id, Integer
    field :recommender_id, Integer
    field :tmdb_id, Integer
    field :media_type, String

    field :recommender, Types::UserType

    field :show, Types::ShowType, null: false

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def show 
      ShowDetailFacade.show_details(object.media_type, object.tmdb_id)
    end
  end
end
