require './lib/avatar_urls'

class User < ApplicationRecord
    include AvatarUrls

    has_many :watchlists
    has_many :sent_recommendations, class_name: "Recommendation", foreign_key: :recommender_id
    has_many :received_recommendations, class_name: "Recommendation", foreign_key: :recommendee_id

    validates_presence_of :username

    after_create :assign_avatar


    def assign_avatar
        update(avatar_url: avatar_urls.sample)
    end 
end