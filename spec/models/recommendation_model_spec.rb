require "rails_helper"

RSpec.describe Recommendation, type: :model do
  describe "Relationships" do 
    it { should belong_to :recommendee }
    it { should belong_to :recommender }
  end
end