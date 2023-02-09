require "rails_helper"

RSpec.describe Recommendation, type: :model do
  describe "Relationships" do 
    it { should belong_to :recommendee }
    it { should belong_to :recommender }
  end

  describe 'validations' do 
    it { should validate_presence_of :tmdb_id }
    it 'will only allow movie or tv as acceptable media_type values' do 
      require 'pry'; binding.pry
    end
  end
end