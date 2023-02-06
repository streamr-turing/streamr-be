class Recommendation < ApplicationRecord
    belongs_to :recommender, class_name: "User"
    belongs_to :recommendee, class_name: "User"
end