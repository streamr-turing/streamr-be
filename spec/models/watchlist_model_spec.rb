require "rails_helper"

RSpec.describe Watchlist, type: :model do
  describe "Relationships" do 
    it { should belong_to :user }
  end
end