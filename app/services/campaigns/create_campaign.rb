class Campaigns::CreateCampaign

  include Virtus.model

  attribute :params, Hash
  attribute :user, User

  # This is the campaign the gets created. We may need it for things such as rebuilding the form with errors
  attribute :campaign, Campaign

  def call
    # if you didn't include the self you would just create an instance variable.
    self.campaign = Campaign.create(params)
    @campaign.user = user
    @campaign.save
  end
  
end
