require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do 
    it { should have_many :received_recommendations }
    it { should have_many :watchlists }
    it { should have_many :sent_recommendations }
  end

  describe 'validations' do 
    it { should validate_presence_of :username}
  end

  describe 'instance methods' do 
    it 'assigns avatar url upon create' do 
      user_1 = User.create!(username: 'james_white_roools')

      expect(user_1.avatar_url).to be_a String
    end
  end
end