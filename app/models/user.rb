require './lib/avatar_urls'

class User < ApplicationRecord
    include AvatarUrls

    has_many :watchlists, dependent: :destroy
    has_many :sent_recommendations, class_name: "Recommendation", foreign_key: :recommender_id, dependent: :destroy
    has_many :received_recommendations, class_name: "Recommendation", foreign_key: :recommendee_id, dependent: :destroy

    validates :username, uniqueness: true, presence: true

    after_create :assign_avatar


    def assign_avatar
        update(avatar_url: avatar_urls.sample)
    end 
end