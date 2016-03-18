require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

  # The first time we call FactoryGirl to make a campaign it assigns a campaign
  # to the @campaign instance variable. This variable can then be used throughout
  # the test.

  let(:user)     {FactoryGirl.create(:user)}
  let(:campaign) {FactoryGirl.create(:campaign, {user: user})}
  let(:campaign) {FactoryGirl.create(:campaign)}
  # let(:user_1)   {FactoryGirl.create(:user)}

  # def campaign
  #   @campaign ||= FactoryGirl.create(:campaign)
  # end
  describe "#new" do
    it "renders the new template" do
      # This mimics sending a get request to the new action
      get :new
      # response is an object that is given to us by RSpec that will help test
      # things like redirect / render
      # render_template is an RSpec (rspec-rails) matcher that helps us check
      # if the controller renders the template with the given name.
      expect(response).to render_template(:new)
    end

    it "instantiates a new Campaign object and set it to @campaign" do
      get :new
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end
  end

  describe "#create" do

    context "with valid attributes" do
      def valid_request
        post :create, campaign:{name: "some valid name",
          description: "some valid description",
          goal: 1000000
        }
      end
      it "creates a record in the database" do
        campaign_count_before = Campaign.count
        valid_request
        campaign_count_after = Campaign.count
        expect(campaign_count_after - campaign_count_before).to eq(1)
      end

      it "redirects to the campaign show page" do
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end

      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end

    end

    context "with invalid attributes" do

      def invalid_request
        post :create, campaign:{name: "some valid name",
          description: "some valid description",
          goal: 2
        }
      end

      it "doesn't create a record in the database" do
        campaign_count_before = Campaign.count
        invalid_request
        campaign_count_after = Campaign.count
        expect(campaign_count_before).to eq(campaign_count_after)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end

  end

  describe "#show" do
    before do
      # GIVEN:
      @campaign = Campaign.create({name: "some valid name",
                           description: "some valid description",
                                  goal: 1000000})
        # WHEN:
        get :show, id: @campaign.id
      end

    it "finds the object by its id and sets it to @campaign variable" do
      # THEN:
      expect(assigns(:campaign)).to eq(@campaign)
    end

    it "renders the show template" do
      #THEN
      expect(response).to render_template(:show)
    end

    it "raises an error if the id passed doesnt match a record in the DB" do
      expect {get :show, id: 321538490253}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "fetches all records and assigns them to @campaigns" do
      # GIVEN
      c = FactoryGirl.create(:campaign)
      c1 = FactoryGirl.create(:campaign)

      # WHEN
      get :index

      #THEN
      expect(assigns(:campaigns)).to eq([c,c1])

    end
  end

  describe "#edit" do
    before do
      get :edit, id: campaign.id
    end

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end

    it "finds the campaign by id and sets it to @campaign instance variable" do
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "#update" do
    context "with valid attributes" do
      it "updates the record with new parameter(s)" do
        # GIVEN
        # We need to have a campaign created in the DB
        # We can make use of the 'campaign' variable we defined using 'let'
        # at the top

        # WHEN
        # Reminder that we are just mimicing an http request here.
        # Also note that if we pass in just the name: variable it will not make
        # any changes to the other parameters
        patch :update, id: campaign.id, campaign: {name: "new valid name"}

        # THEN
        # We must use campaign.reload in this scenario because the controller
        # will instantiate another campaign object based on the id but it will
        # live in another memory location. Which means 'campaign' here will still
        # have teh old data not the possibly updated one. Reload will make
        # ActiveRecord rerun the query and fetch the information from the DB again.
        expect(campaign.reload.name).to eq("new valid name")
      end

      it "redirects to the campaign show page" do
        patch :update, id: campaign.id, campaign: {name: "new valid name"}
        expect(response).to redirect_to(campaign_path(campaign.reload))
      end

      it "sets a flash notice method" do
        patch :update, id: campaign.id, campaign: {name: "new valid name"}
        # to be means to not be nil
        expect(flash[:notice]).to be
      end

    end

    context "with invalid attributes" do
        it "doesn't update the record" do
          campaign_goal_before = campaign.goal
          patch :update, id: campaign.id, campaign: {goal: 6}
          expect(campaign.reload.goal).to eq(campaign_goal_before)
        end

        it "renders the edit template" do
          patch :update, id: campaign.id, campaign: {name: ""}
          expect(response).to render_template(:edit)
        end

        it "sets a flash alert message" do
          patch :update, id: campaign.id, campaign: {name: ""}
          expect(flash[:alert]).to be
        end
    end
  end

  describe "#destroy" do

    context "with user not signed in" do
      it "redirects to the sign in page" do
        delete :destroy, id: campaign.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with signed in user" do
      before {signin(user)}

      context "with signed in user as owner of campaign" do
        # this forces the let to reload before the method is called
        #let!(:campaign) {FactoryGirl.create(:campaign)}
        it "removes the campaigns from the database" do
          # one line that does the same as all the code below
          #expect { delete :destroy, id: campaign.id}.to change {Campaign.count}.by(-1)
          campaign
          campaign_count_before = Campaign.count
          delete :destroy, id: campaign.id
          expect(campaign_count_before-Campaign.count).to eq(1)
        end

        it "redirect to the campaign index page" do
          delete :destroy, id: campaign.id
          expect(response).to redirect_to(campaigns_path)
        end

        it "sets a flash method" do
          delete :destroy, id: campaign.id
          expect(flash[:notice]).to be
        end

      end

      context "with signed in user as not the owner of the campaign" do
        it "raises and error" do
          expect do
            delete :destroy , id: campaign_1.id
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
