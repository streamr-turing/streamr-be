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

    def users
      User.all
    end

    field :shows,
    [Types::ShowsType],
    null: false do
      argument :query, String, required: true
    end

    def shows(query:)
      SearchFacade.search_results(query)
    end
  end
end
