module Mutations
  class DeleteWatchlist < BaseMutation 
    argument :id, ID, required: true

    type Types::WatchlistType
    def resolve(id:)
      watchlist = Watchlist.find(id)
      watchlist.destroy
    end
  end
end