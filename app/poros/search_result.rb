class SearchResult
  attr_reader :tmdbId, :imageUrl, :title, :yearCreated, :mediaType, :rating, :genres

  def initialize(attributes)
    genres = {28 => "Action", 12 => "Adventure", 16 => "Animation", 35 => "Comedy", 80 => "Crime", 99 => "Documentary", 18 => "Drama", 10751 => "Family", 14 => "Fantasy", 36 => "History", 27 => "Horror", 10402 => "Music", 9648 => "Mystery", 10749 => "Romance", 878 => "Science Fiction", 10770 => "TV Movie", 53 => "Thriller", 10752 => "War", 10759 => "Action & Adventure", 10762 => "Kids", 10763 => "News", 10764 => "Reality", 10765 => "Sci-Fi & Fantasy", 10766 => "Soap", 10767 => "Talk", 10768 => "War & Politics", 37 => "Western"}

    @tmdbId = attributes[:id]
    @genres = attributes[:genre_ids].map{|genre_id| genres[genre_id]}
    @imageUrl = create_image_url(attributes)

    # @mediaType = attributes[:media_type]
    @mediaType = "tv"
    @rating = attributes[:vote_average]

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
