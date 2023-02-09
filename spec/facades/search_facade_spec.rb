require 'rails_helper'

RSpec.describe SearchFacade do
  it '.search_results', :vcr do
    search_results = SearchFacade.search_results('Bradley')
    expect(search_results).to be_an Array
    # require "pry"; binding.pry
    # expect(search_results[0]).to be_an_instance_of(Show)
  end
end
