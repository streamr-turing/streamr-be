class SearchResult
  attr_reader :tmdbId, :imageUrl, :title, :yearCreated, :mediaType

  def initialize(attributes)
    @tmdbId = attributes[:id]
    @imageUrl = create_image_url(attributes)
    @mediaType = attributes[:media_type]
    find_title(attributes)
    find_year(attributes)
  end

  def create_image_url(attributes)
    if attributes[:poster_path]
      return "https://image.tmdb.org/t/p/w500/" + attributes[:poster_path]
    else
      return nil
    end
  end

  def find_year(attributes)
    if @mediaType == "movie"
      @yearCreated = attributes[:release_date]
    elsif @mediaType == "tv"
      @yearCreated = attributes[:first_air_date]
    end
  end

  def find_title(attributes)
    if @mediaType == "movie"
      @title = attributes[:title]
    elsif @mediaType == "tv"
      @title = attributes[:name]
    end
  end
end
