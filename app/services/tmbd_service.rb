class TmbdService
    def self.get_url(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.conn
     Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api_key'] = ENV['tmdb_api_key']
      faraday.params['language'] = 'en-US'
     end
    end

    def self.search_multi(query)
      get_url("/3/search/multi", { query: "#{query}", page: 1, include_adult: false })
    end

    def self.details(type, id)
      get_url("/3/#{type}/#{id}")
    end

    def self.streaming_service(type, id)
      get_url("/3/#{type}/#{id}/watch/providers")
    end

  end