class Show
  attr_reader :tmdbId, :title, :releaseYear, :streamingService, :posterUrl, :genres, :rating, :summary, :recommendedBy, :mediaType

  def initialize(details, streaming_data, type)
    @tmdbId = details[:id]
    @streamingService = format_streaming_data(streaming_data[:flatrate])
    @posterUrl = create_poster_url(details)
    @genres = details[:genres].map {|genre| genre[:name]}
    @rating = details[:vote_average]
    @summary = details[:overview]
    @mediaType = type
    find_title(type, details)
    find_year(type, details)
  end

  def find_title(type, details)
    if type == "movie"
      @title = details[:title]
    elsif type == "tv"
      @title = details[:name]
    end
  end

  def find_year(type, details)
    if type == "movie"
      @releaseYear = details[:release_date][0..3]
    elsif type == "tv"
      @releaseYear = details[:first_air_date][0..3]
    end
  end

  def recommended_by(users)
    @recommendedBy = users
  end

  def create_poster_url(details)
    return "https://image.tmdb.org/t/p/w500" + details[:poster_path] if details[:poster_path]
  end

  def format_streaming_data(streaming_data)
    return if streaming_data.nil?
    formatted_data = streaming_data.each {|provider| provider.delete_if {|key, value| key != :logo_path && key != :provider_name}}
    formatted_data.each {|provider| provider[:logo_path] = "https://image.tmdb.org/t/p/w500" + provider[:logo_path]}
    formatted_data
  end
end
