class SearchFacade
  def self.search_results(query)
    search = TmbdService.search_multi(query,1)
    total_pages = search[:total_pages]
    search_results = search[:results].map do |result|
      if result[:media_type] != "person"
        SearchResult.new(result)
      end
    end
    # if total_pages > 5
    #
    # elsif total_pages > 1
    #
    # end
    search_results.compact
  end
end
