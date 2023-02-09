module Types
  class MutationType < Types::BaseObject
    field :create_recommendation, mutation: Mutations::CreateRecommendation
    field :create_watchlist_item, mutation: Mutations::CreateWatchlistItem
    field :delete_watchlist_item, mutation: Mutations::DeleteWatchlistItem
  end
end
