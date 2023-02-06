require "rails_helper"

RSpec.describe User, type: :model do
  describe "Relationships" do 
    it { should have_many :received_recommendations }
    it { should have_many :watchlists }
    it { should have_many :sent_recommendations }
  end
end