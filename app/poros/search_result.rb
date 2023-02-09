class SearchResult
  attr_reader :tmdbId, :title, :imageUrl, :yearCreated, :mediaType

  def initialize(attributes)
    @tmdbId = attributes[:id]
    @imageUrl = attributes[:poster_path]
    @mediaType = attributes[:media_type]
    find_title(attributes)
    find_year(attributes)
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
