require 'spec_helper'

describe LocationsController do
  describe "GET index" do
    it "sets @locations" do
      location1 = Fabricate(:location)
      location2 = Fabricate(:location)
      get :index
      expect(assigns(:locations)).to match_array([location1, location2])
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      it "redirects to the home_path" do
        post :create, location: Fabricate.attributes_for(:location)
        expect(response).to redirect_to home_path
      end
      
      it "creates the location" do
        post :create, location: Fabricate.attributes_for(:location)
        expect(Location.count).to eq(1)
      end
      
      it "creates the location associated with the user" do
        user = Fabricate(:user)
        set_current_user(user)
        post :create, location: Fabricate.attributes_for(:location)
        expect(Location.first.user).to eq(user)
      end
      
      it "creates latitude and longitude for location"
    end
    
    context "with invalid inputs"do
      before do
        set_current_user
        post :create, location: { address: nil }
      end
      
      it "displays error message" do
        expect(flash[:error]).to be_present 
      end
      
      it "does not create the location" do
        expect(Location.count).to eq(0)
      end
      
      it "renders :index" do
        expect(response).to render_template :index
      end
    end
  end
end

