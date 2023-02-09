# module Queries
#   class FetchShowDetails < Queries::BaseQuery
#     type Types::ShowType, null: false
#     argument :tmdbId, Integer
#     argument :userId, Integer
#     argument :mediaType, String
#
#     def resolve(tmdbID:, userID:, mediaType:)
#       ShowDetailFacade.show_details(mediaType, tmdbID)
#
#     # rescue ActiveRecord::RecordNotFound => _e
#     #   GraphQL::ExecutionError.new('Artist does not exist.')
#     # rescue ActiveRecord::RecordInvalid => e
#     #   GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
#     #     " #{e.record.errors.full_messages.join(', ')}")
#     end
#   end
# end
