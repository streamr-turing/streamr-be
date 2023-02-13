require 'rails_helper'

RSpec.describe SearchResult do
  it 'exists and has attributes', :vcr do
    attributes = {:adult=>false,
                  :backdrop_path=>"/o0s4XsEDfDlvit5pDRKjzXR4pp2.jpg",
                  :id=>19995,
                  :title=>"Avatar",
                  :original_language=>"en",
                  :original_title=>"Avatar",
                  :overview=>
                  "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
                  :poster_path=>"/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
                  :media_type=>"movie",
                  :genre_ids=>[28, 12, 14, 878],
                  :popularity=>740.334,
                  :release_date=>"2009-12-15",
                  :video=>false,
                  :name=>"Avatar",
                  :vote_average=>7.567,
                  :vote_count=>28271}

    search_result = SearchResult.new(attributes)

    expect(search_result).to be_an_instance_of(SearchResult)
    expect(search_result.tmdbId).to eq(19995)
    expect(search_result.imageUrl).to eq("https://image.tmdb.org/t/p/w500//jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg")
    expect(search_result.title).to eq("Avatar")
    # expect(search_result.yearCreated).to eq("2009-12-15")
    # expect(search_result.mediaType).to eq("movie")
    expect(search_result.rating).to eq(7.567)
    expect(search_result.genres).to eq(["Action", "Adventure", "Fantasy", "Science Fiction"])
  end
end
