require 'rails_helper'

RSpec.describe ShowDetailFacade do
  context '.show_details', :vcr do
    it 'can retrieve multiple pages of results at once' do
      show_details = ShowDetailFacade.show_details('movie', 278)
      expect(show_details).to be_an_instance_of Show
    end
  end
end
