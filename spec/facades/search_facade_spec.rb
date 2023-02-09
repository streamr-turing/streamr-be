require 'rails_helper'

RSpec.describe SearchFacade do
  it '.search_results', :vcr do
    search_results = SearchFacade.search_results('Avatar')
    expect(search_results).to be_an Array
    # expect(search_results[0]).to be_an_instance_of(Show)
  end
end
