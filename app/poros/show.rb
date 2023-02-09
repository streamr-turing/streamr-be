# class Show
#   attr_reader :tmdbId, :title, :releaseYear, :streamingService, :posterUrl, :genres, :rating, :summary
#
#   def initialize(details, streaming_data)
#     @tmdbId = details[:id]
#     @title = details[:title]
#     @releaseYear = details[:release_date]
#     @streamingService = streaming_data #format_streaming_data(streaming_data)
#     @posterUrl = create_poster_url(details)
#     @genres = details[:genres]
#     @rating = details[:vote_average]
#     @summary = details[:overview]
#   end
#
#   def create_poster_url(details)
#     return "https://image.tmdb.org/t/p/w500/" + details[:poster_path] if details[:poster_path]
#   end
#
#   def format_streaming_data(streaming_data)
#
#   end
# end
