require "rails_helper"

RSpec.describe Watchlist, type: :model do
  describe "Relationships" do 
    it { should belong_to :user }
  end

  describe 'validations' do 
    it { should validate_presence_of :tmdb_id }
    it 'will only allow movie or tv as acceptable media_type values' do 
      user = create(:user)
      wl1 = Watchlist.new(user_id: user.id, tmdb_id: 10, media_type: 'boogers')
      wl2 = Watchlist.new(user_id: user.id, tmdb_id: 10, media_type: 'movie')
      wl3 = Watchlist.new(user_id: user.id, tmdb_id: 10, media_type: 'tv')

      expect(wl1.save).to eq(false)
      expect(wl2.save).to eq(true)
      expect(wl3.save).to eq(true)
    end
  end
end