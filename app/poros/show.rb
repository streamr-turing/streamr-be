class Show
  attr_reader :tmdbId, :title, :releaseYear, :streamingService, :posterUrl, :genres, :rating, :summary

  def initialize(details, streaming_data)
    @tmdbId = details[:id]
    @title = details[:title]
    @releaseYear = details[:release_date]
    # @streamingService = streaming_data[:flatrate] #format_streaming_data(streaming_data)
    @streamingService = format_streaming_data(streaming_data[:flatrate])
    @posterUrl = create_poster_url(details)
    @genres = details[:genres].map {|genre| genre[:name]}
    @rating = details[:vote_average]
    @summary = details[:overview]

    # require "pry"; binding.pry
  end

  def recommended_by(users)
    @recommendedBy = users
  end

  def create_poster_url(details)
    return "https://image.tmdb.org/t/p/w500/" + details[:poster_path] if details[:poster_path]
  end

  def format_streaming_data(streaming_data)
    # require "pry"; binding.pry
    formatted_data = streaming_data.each {|provider| provider.delete_if {|key, value| key != :logo_path && key != :provider_name}}
    formatted_data.each {|provider| provider[:logo_path] = "https://image.tmdb.org/t/p/w500/" + provider[:logo_path]}
    formatted_data
  end

  def format_genres(details)

  end
end
