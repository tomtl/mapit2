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
end