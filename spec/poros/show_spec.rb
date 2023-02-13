require 'rails_helper'

RSpec.describe Show do
  it 'exists and has attributes', :vcr do
    details = {:adult=>false,
              :backdrop_path=>"/wPU78OPN4BYEgWYdXyg0phMee64.jpg",
              :genres=>[{:id=>18, :name=>"Drama"}, {:id=>80, :name=>"Crime"}],
              :id=>278,
              :imdb_id=>"tt0111161",
              :original_title=>"The Shawshank Redemption",
              :overview=>"Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
              :popularity=>111.799,
              :poster_path=>"/hBcY0fE9pfXzvVaY4GKarweriG2.jpg",
              :release_date=>"1994-09-23",
              :title=>"The Shawshank Redemption",
              :vote_average=>8.702}
    streaming_data = {:link=>"https://www.themoviedb.org/movie/278-the-shawshank-redemption/watch?locale=US",
                      :flatrate=>
                      [{:logo_path=>"/Ajqyt5aNxNGjmF9uOfxArGrdf3X.jpg",
                        :provider_name=>"HBO Max"},
                       {:logo_path=> "/qNVZUR6koKFlOFdycB0D9cewBEm.jpg",
                        :provider_name=>"HBO Max Amazon Channel"},
                       {:logo_path=>"/xL9SUR63qrEjFZAhtsipskeAMR7.jpg",
                        :provider_name=>"DIRECTV"}]}
    type = "movie"

    show = Show.new(details, streaming_data, type)

    expect(show).to be_an_instance_of(Show)
    expect(show.title).to eq("The Shawshank Redemption")
    expect(show.releaseYear).to eq("1994")
    expect(show.streamingService).to eq([{:logo_path=>"https://image.tmdb.org/t/p/w500/Ajqyt5aNxNGjmF9uOfxArGrdf3X.jpg", :provider_name=>"HBO Max"}, {:logo_path=>"https://image.tmdb.org/t/p/w500/qNVZUR6koKFlOFdycB0D9cewBEm.jpg", :provider_name=>"HBO Max Amazon Channel"}, {:logo_path=>"https://image.tmdb.org/t/p/w500/xL9SUR63qrEjFZAhtsipskeAMR7.jpg", :provider_name=>"DIRECTV"}])
    expect(show.posterUrl).to eq("https://image.tmdb.org/t/p/w500/hBcY0fE9pfXzvVaY4GKarweriG2.jpg")
    expect(show.genres).to eq(["Drama", "Crime"])
    expect(show.rating).to eq(8.702)
    expect(show.summary).to eq("Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
    expect(show.mediaType).to eq("movie")
  end
end
