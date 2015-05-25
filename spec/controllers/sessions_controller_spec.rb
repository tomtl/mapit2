require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      let(:user) { Fabricate(:user) }
      before { post :create, email: user.email, password: user.password }

      it "puts the signed in user into the sessions" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the home path" do
        expect(response).to redirect_to home_path
      end

      it "sets the notice" do
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid credentials" do
      let(:user) { Fabricate(:user) }
      before { post :create, email: user.email, password: user.password + "abcd" }

      it "does not put the user into the session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets the error message" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET destroy" do
    before do
      set_current_user
      get :destroy
    end

    it "removes the user from the session" do
      expect(session[:user_id]).to be_nil
    end

    it "displays a message" do
      expect(flash[:notice]).to be_present
    end

    it "redirects to the front page" do
      expect(response).to redirect_to root_path
    end
  end
end
