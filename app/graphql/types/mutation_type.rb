module Types
  class MutationType < Types::BaseObject
    field :create_recommendation, mutation: Mutations::CreateRecommendation
  end
end
