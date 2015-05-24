require 'spec_helper'

describe LocationsController do
  describe "GET index" do
    it "sets @locations" do
      user = Fabricate(:user)
      set_current_user(user)
      location1 = Fabricate(:location, user: user)
      location2 = Fabricate(:location, user: user)
      get :index
      expect(assigns(:locations)).to match_array([location1, location2])
    end

    it "only shows locations that belong to the signed in user" do
      user1 = Fabricate(:user)
      set_current_user(user1)
      location1 = Fabricate(:location, user: user1)
      location2 = Fabricate(:location, user: user1)
      location3 = Fabricate(:location, user: Fabricate(:user))
      get :index
      expect(assigns(:locations)).to match_array([location1, location2])
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      it "redirects to the home_path" do
        set_current_user
        post :create, location: Fabricate.attributes_for(:location)
        expect(response).to redirect_to home_path
      end

      it "creates the location" do
        set_current_user
        post :create, location: Fabricate.attributes_for(:location)
        expect(Location.count).to eq(1)
      end

      it "creates the location associated with the user" do
        user = Fabricate(:user)
        set_current_user(user)
        post :create, location: Fabricate.attributes_for(:location)
        expect(Location.first.user).to eq(user)
      end

      it "creates latitude and longitude for location" do
        user = Fabricate(:user)
        set_current_user(user)
        post :create, location: Fabricate.attributes_for(:location)
        expect(Location.first.latitude).to be_present
      end
    end

    context "with invalid inputs" do
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

    context "for non-authenticated users" do
      before { post :create, location: Fabricate.attributes_for(:location)
 }

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "does not create a location" do
        expect(Location.count).to eq(0)
      end
    end
  end

  describe "GET show" do
    it "sets @location for authenticated users" do
      set_current_user
      get :show, id: Fabricate(:location).id
      expect(assigns(:location)).to be_instance_of(Location)
    end

    it "redirects to the sign in page for unauthenticated users" do
      get :show, id: Fabricate(:location).id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "GET edit" do
    it "sets @location for authenticated user" do
      set_current_user
      get :edit, id: Fabricate(:location).id
      expect(assigns(:location)).to be_instance_of(Location)
    end

    it "redirects to sign in page for unauthenticated users" do
      get :edit, id: Fabricate(:location).id
      expect(response).to redirect_to sign_in_path
    end

    it "redirects to home page if location does not belong to user" do
      signed_in_user = Fabricate(:user)
      location_owner = Fabricate(:user)
      set_current_user(signed_in_user)
      location = Fabricate(:location, user: location_owner)
      get :edit, id: location.id
      expect(response).to redirect_to home_path
    end
  end

  describe "POST update" do
    context "with valid inputs" do
      before do
        user = Fabricate(:user)
        set_current_user(user)
        @location = Fabricate(:location, user: user)
        @new_address = Fabricate(:location).address
        patch :update, id: @location.id, location: { address: @new_address }
      end

      it "sets @location" do
        expect(assigns(:location)).to be_instance_of(Location)
      end

      it "updates the address" do
        expect(Location.find(@location.id).address).to eq(@new_address)
      end

      it "redirects to the location page" do
        expect(response).to redirect_to location_path(@location)
      end

      it "displays a confirmation message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before do
        user = Fabricate(:user)
        set_current_user(user)
        @location = Fabricate(:location, user: user)
        patch :update, id: @location.id, location: { address: "" }
      end

      it "renders the edit location page" do
        expect(response).to render_template :edit
      end
      it "does not update the location" do
          expect(Location.find(@location.id).address).to eq(@location.address)
      end

      it "shows an error message" do
        expect(flash[:error]).to be_present
      end
    end

    context "for unauthenticated users" do
      before do
        @location = Fabricate(:location)
        @new_address = Fabricate(:location).address
        patch :update, id: @location.id, location: { address: @new_address }
      end

      it "redirects to the sign in page if the user is not signed in" do
        expect(response).to redirect_to sign_in_path
      end

      it "does not update the location if the user is not signed in" do
        expect(Location.find(@location.id).address).to eq(@location.address)
      end

      it "shows an error message" do
        expect(flash[:error]).to be_present
      end
    end

    context "for locations that do not belong to the user" do
      before do
        user1 = Fabricate(:user)
        set_current_user(user1)
        @location = Fabricate(:location, user: Fabricate(:user))
        patch :update, id: @location.id, location: { address: "123 Main Street, New York" }
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end

      it "does not update the location" do
        expect(Location.find(@location.id).address).to eq(@location.address)
      end

      it "shows an error message" do
        expect(flash[:error]).to be_present
      end
    end
  end
end
