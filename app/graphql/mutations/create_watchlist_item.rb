module Mutations
  class CreateWatchlistItem < BaseMutation 
    argument :tmdb_id, Integer, required: true
    argument :user_id, Integer, required: true
    argument :media_type, String, required: true

    type Types::WatchlistItemType
    def resolve(tmdb_id:, user_id:, media_type:)
      WatchlistItem.create!(
        tmdb_id: tmdb_id,
        user_id: user_id,
        media_type: media_type
      )
    end
  end
end