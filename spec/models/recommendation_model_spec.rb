require "rails_helper"

RSpec.describe Recommendation, type: :model do
  describe "Relationships" do 
    it { should belong_to :recommendee }
    it { should belong_to :recommender }
  end

  describe 'validations' do 
    it { should validate_presence_of :tmdb_id }
    it 'will only allow movie or tv as acceptable media_type values' do 
      user = create(:user)
      user2 = create(:user)
      rec1 = Recommendation.new(recommender_id: user2.id, recommendee_id: user.id, tmdb_id: 10, media_type: 'boogers')
      rec2 = Recommendation.new(recommender_id: user2.id, recommendee_id: user.id, tmdb_id: 10, media_type: 'movie')
      rec3 = Recommendation.new(recommender_id: user2.id, recommendee_id: user.id, tmdb_id: 10, media_type: 'tv')

      expect(rec1.save).to eq(false)
      expect(rec2.save).to eq(true)
      expect(rec3.save).to eq(true)
    end
  end
end