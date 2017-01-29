require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  let(:user) { create(:user) }

  let(:valid_attributes) {
    FactoryGirl.build(:event, user: user).attributes
  }

  let(:invalid_attributes) {
    FactoryGirl.build(:event, name: " ").attributes
  }


  before(:each) do 
    @auth_headers = user.create_new_auth_token
  end  

  describe "GET #index" do
    it "assigns all events as @events" do
      event = Event.create! valid_attributes
      get :index, params: {}.merge(@auth_headers)
      expect(assigns(:events)).to eq([event])
    end


    context "without params" do
      before(:each) do 
        create(:event, when: DateTime.now + 1.day,
          user: user)
        create(:event, name: "Event 2",
          when: DateTime.now + 2.days, user: user)
        event_where_participant = create(:event, 
          user: user, when: DateTime.now + 3.days)
        create(:follow, follower_id: user.id, followable_id: event_where_participant.id)
        create(:event, user: user)
        get :index, params: {}.merge(@auth_headers)
      end  

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end    
      
      it "sends a list of events where user is participant" do
        json = JSON.parse(response.body)
        expect(json.length).to eq(4)
      end  

      it "sends a list in a correct order" do
        json = JSON.parse(response.body)
        expect(json.first["name"]).to eq("Test Event 1")
        expect(json.second["name"]).to eq("Event 2")
      end  
    end

    context "with params" do
      before(:each) do 
        FactoryGirl.create(:event, when: DateTime.now + 1.day,
          user: user)
        FactoryGirl.create(:event, name: "Event 2",
          when: DateTime.now + 3.days, user: user)
      end  

      it "sends a list of events in right interval" do
        get :index, params: { interval: "2d" }.merge(@auth_headers)
        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json.length).to eq(1)
      end

    end
  end

  describe "GET #show" do
    it "assigns the requested event as @event" do
      event = Event.create! valid_attributes
      get :show, params: {id: event.to_param}.merge(@auth_headers)
      expect(response).to be_success
      expect(assigns(:event)).to eq(event)
    end


  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, params: {event: valid_attributes}.merge(@auth_headers)
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, params: {event: valid_attributes}.merge(@auth_headers)
        expect(assigns(:event)).to be_a(Event)
        expect(assigns(:event)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        post :create, params: {event: invalid_attributes}.merge(@auth_headers)
        expect(assigns(:event)).to be_a_new(Event)
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      FactoryGirl.build(:event, name: "Some Other Event").attributes
    }

    context "with valid params" do

      it "updates the requested event" do
        event = Event.create! valid_attributes
        put :update, params: {id: event.to_param, 
          event: new_attributes}.merge(@auth_headers)
        event.reload
        expect(assigns(:event).name).to eq("Some Other Event")
      end

      it "assigns the requested event as @event" do
        event = Event.create! valid_attributes
        put :update, params: {id: event.to_param,
          event: valid_attributes}.merge(@auth_headers)
        expect(response).to be_success
        expect(assigns(:event)).to eq(event)
      end
    end

    context "with invalid params" do
      it "assigns the event as @event" do
        event = Event.create! valid_attributes
        put :update, params: { id: event.to_param,
          event: invalid_attributes }.merge(@auth_headers)
        expect(assigns(:event)).to eq(event)
      end

  
    end
  end

end