class Campaigns::PublishCampaign

  include Virtus.model

  attribute :campaign, Campaign

  # Recommended to have one public method called call. Every other method should be private
  def call
      campaign.publish! && schedule_background_job
      # if campaign.publish!
      #   schedule_background_job
      # else
      #   false
      # end
  end

  private

  def schedule_background_job
    DetermineCampaignStateJob.set(wait_until: campaign.end_date).perform_later(campaign)
    true
  end

end
