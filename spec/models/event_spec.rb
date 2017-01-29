require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "event" do 

    it "should be created" do
      event_count = Event.count	
      create(:event)
      expect(Event.count).to eq(event_count + 1)
    end

    it "should not be created if name.length = 0" do
      event_count = Event.count
      expect {
        create(:event, name: " ")
      }.to raise_error(ActiveRecord::RecordInvalid)
      expect(Event.count).to eq(event_count)
    end

  end
end