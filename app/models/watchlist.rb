class Watchlist < ApplicationRecord
    belongs_to :user

    validates_with MediaTypeValidator
    validates_presence_of :tmdb_id
end