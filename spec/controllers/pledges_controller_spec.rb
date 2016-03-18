require 'rails_helper'

RSpec.describe PledgesController, type: :controller do

  let(:campaign) {FactoryGirl.create(:campaign)}
  let(:user)     {FactoryGirl.create(:user)}
  let(:pledge)   {FactoryGirl.create(:pledge, {campaign: campaign, user: user})}
  let(:pledge_1) {FactoryGirl.create(:pledge)}
  describe "#create" do
    context "with no signed in user" do
      it "redirects to the sign in page" do
        post :create, campaign_id: campaign.id,
                       pledge: FactoryGirl.attributes_for(:pledge)
        # if you ran this command it would create a pledge assocaited with a particular campaign
        # FactoryGirl.create(pledge: campaign.id)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with signed in user" do

      before do
        signin(user) # this is coming from the LoginHelpers module inside the support folder
      end

      context "with valid params" do
        def send_valid_request
          post :create, campaign_id: campaign.id,
                         pledge: FactoryGirl.attributes_for(:pledge)
        end

        it "creates a pledge in the database associated with the campaign" do
          count_before = campaign.pledges.count
          send_valid_request
          count_after = campaign.pledges.count
          expect(count_after - count_before).to eq(1)
        end

        it "associates the pledge with the logged in user" do
          # GIVEN - have a campaign, a user that is logged in. This is taken
          # care of by the before and the send_valid_request
          # THEN - the user makes a pledge
          send_valid_request
          expect(Pledge.last.user).to eq(user)
        end

        it "redirects to the campaign show page"
        it "sets a flash notice message"

      end

      context "with invalid params" do
      end

    end
  end

  describe "#destroy" do
    context "with no signed in user" do
      it "redirects to the sign in page" do
      delete :destroy, id: pledge.id, campaign_id: campaign.id
      expect(response).to redirect_to(new_session_path)
      end
    end

    context "with signed in user" do
      before do
        signin(user)
      end

      context "with signed in user as the owner of the pledge" do
        it "removes the pledge from the database" do
          pledge # to force create the pledge before we get the count
          count_before = Pledge.count
          delete :destroy, id: pledge.id, campaign_id: campaign.id
          count_after = Pledge.count
          expect(count_after - count_before).to eq(-1)
        end

        it "redirects to the campaign show page" do
          delete :destroy, id: pledge.id, campaign_id: campaign.id
          expect(response).to redirect_to(campaign_path(campaign))
        end

      end

      context "with signed in user not the owner of the pledge" do
        it "raises an error" do
          expect do
            delete :destroy, id: pledge_1.id, campaign_id: pledge_1.campaign_id
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
