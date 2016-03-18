require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiate a user object and sets it to @user instance" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

  end

  describe "#create" do
    def send_valid_request
      post :create, user: FactoryGirl.attributes_for(:user)
    end
    context "successful create" do
      it "creates a user record in the database" do
        count_before = User.count
        send_valid_request
        count_after = User.count
        expect(count_after - count_before).to eq(1)
      end

      it "redirects to the home page" do
        send_valid_request
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash notice message" do
        send_valid_request
        expect(flash[:notice]).to be
      end

      it "sets the session user_id to the created user" do
        send_valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end

    end

    context "unsuccessful create" do
      def send_invalid_request
        post :create, user: FactoryGirl.attributes_for(:user, {email: nil})
      end

      it "doesn't create a user record in the database" do
        count_before = User.count
        send_invalid_request
        count_after = User.count
        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        send_invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash alert message" do
        send_invalid_request
        expect(flash[:alert]).to be
      end

    end
  end

end
