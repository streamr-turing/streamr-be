module Types
  class MutationType < Types::BaseObject
    field :create_recommendation, mutation: Mutations::CreateRecommendation
    field :create_watchlist, mutation: Mutations::CreateWatchlist
    field :delete_watchlist, mutation: Mutations::DeleteWatchlist
  end
end
