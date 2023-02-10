# # frozen_string_literal: true

module Types
  class StreamingServiceType < Types::BaseObject
    # field :id, ID, null: false
    field :logo_path, String
    field :provider_name, String
  end
end
