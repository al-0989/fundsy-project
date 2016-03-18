require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) {create(:user)} #By adding the line config.include FactoryGirl::Syntax::Methods to the rails helper file.
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

  end

  describe "#create" do
    context "with valid credentials" do
      before do
        post :create, email: user.email, password: user.password
      end

      it "sets the session user_id to the user with the passed email" do
        # pass to the session user email and password
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the root path" do
        # pass to the session user email and password
        expect(response).to redirect_to(root_path)
      end

      it "sets the flash notice message" do
        # pass to the session user email and password
        expect(flash[:notice]).to be
      end
    end

    context "with invalid credentials"

    before do
      # pass to the session user email and password
      post :create, {email: user.email, password: nil}
    end

      it "renders the sign in page (new template)" do
        expect(response).to render_template(:new)
      end

      it "sets a flash alert message" do
        expect(flash[:alert]).to be
      end

      it "doesn't set session user_id if email is correct and password is wrong" do
        expect(session[:user_id]).to be(nil)
      end
  end

  describe "#destroy" do
    before do
      request.session[:user_id] = user.id
      delete :destroy
    end
    it "sets the session user_id to nil" do
      expect(session[:user_id]).not_to be
    end

    it "sets a flash notice message" do
      expect(flash[:notice]).to be
    end

    it "redirect to the root path" do
      expect(response).to redirect_to(:root)
    end
  end
end
