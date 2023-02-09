module Mutations
  class DeleteWatchlistItem < BaseMutation 
    argument :id, ID, required: true

    type Types::WatchlistItemType
    def resolve(id:)
      watchlist_item = WatchlistItem.find(id)
      watchlist_item.destroy
    end
  end
end