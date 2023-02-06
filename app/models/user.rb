class User < ApplicationRecord
    has_many :watchlists
    has_many :sent_recommendations, class_name: "Recommendation", foreign_key: :recommender_id
    has_many :received_recommendations, class_name: "Recommendation", foreign_key: :recommendee_id
end