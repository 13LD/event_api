require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe "follow" do
    before(:each) { @follow = create(:follow) }

    it "should be created" do
      expect(@follow).to be_valid
      expect(Follow.count).to eq(1)
    end

    it "should not be created if user does not exist" do
      expect {
        create(:follow, follower_id: 150)
      }
      expect(Follow.count).to eq(1)
    end 

    it "should not be created if event does not exist" do
      expect {
        create(:follow, followable_id: 1544)
      }
      expect(Follow.count).to eq(1)
    end 
  end
end