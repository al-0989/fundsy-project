class PledgesMailer < ApplicationMailer

  def notify_campaign_owner(pledge)
   @campaign = pledge.campaign
   @owner    = @campaign.user
   @pledge   = pledge
   mail(to: @owner.email, subject: "Someone Pledges to Your Campaign!")
 end
 
end
