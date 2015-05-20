require 'spec_helper'

describe UsersController do
  describe "POST create" do
    context "with valid input" do
      it "creates the user"
      it "redirects to the home page"
    end
    
    context "with invalid input" do
      it "does not create the user"
      it "renders the :new template"
      it "sets @user"
    end
  end
end