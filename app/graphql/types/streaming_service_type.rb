# # frozen_string_literal: true

module Types
  class StreamingServiceType < Types::BaseObject
    # field :id, ID, null: false
    field :logo_path, String
    field :provider_name, String
  end
end

# @streamingService=
#   [{:logo_path=>
#      "https://image.tmdb.org/t/p/w500//Ajqyt5aNxNGjmF9uOfxArGrdf3X.jpg",
#     :provider_name=>"HBO Max"},
#    {:logo_path=>
#      "https://image.tmdb.org/t/p/w500//qNVZUR6koKFlOFdycB0D9cewBEm.jpg",
#     :provider_name=>"HBO Max Amazon Channel"},
#    {:logo_path=>
#      "https://image.tmdb.org/t/p/w500//xL9SUR63qrEjFZAhtsipskeAMR7.jpg",
#     :provider_name=>"DIRECTV"}],
