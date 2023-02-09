require 'rails_helper'

RSpec.describe SearchFacade do
  context '.search_results', :vcr do
    it 'can retrieve multiple pages of results at once' do
      search_results = SearchFacade.search_results('Avatar')
      expect(search_results).to be_an Array
      expect(search_results[0]).to be_an_instance_of(SearchResult)
      expect(search_results.count).to be > 20
    end
    it 'caps number of results at 100' do
      search_results = SearchFacade.search_results('the')
      expect(search_results).to be_an Array
      expect(search_results[0]).to be_an_instance_of(SearchResult)
      expect(search_results.count).to eq(100)
    end
  end
end
