class SearchFacade
  def self.search_results(query)
    search = TmdbService.search_multi(query,1)
    total_pages = search[:total_pages]
    search_results = search[:results].map do |result|
      if result[:media_type] != "person"
        SearchResult.new(result)
      end
    end

    if total_pages > 5
      4.times do |i|
        results = TmdbService.search_multi(query, i + 2)[:results].map do |result|
          if result[:media_type] != "person"
            SearchResult.new(result)
          end
        end
        search_results = search_results + results
      end
    elsif total_pages > 1
      (total_pages - 1).times do |i|
        results = TmdbService.search_multi(query, i + 2)[:results].map do |result|
          if result[:media_type] != "person"
            SearchResult.new(result)
          end
        end
        search_results = search_results + results
      end
    end
    search_results.compact
  end
end
