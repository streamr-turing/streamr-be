class ShowDetailFacade
  def self.show_details(type, id)
    streaming_data = TmdbService.streaming_service(type, id)[:results][:US]
    details = TmdbService.details(type, id)
    Show.new(details, streaming_data, type)
  end
end
