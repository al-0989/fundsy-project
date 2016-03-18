module CampaignsHelper

  def markers(campaigns)
    Gmaps4rails.build_markers(campaigns) do |campaign, marker|
      marker.lat campaign.latitude
      marker.lng campaign.longitude
      campaign_link = link_to campaign.name, campaign_path(campaign)
      marker.infowindow campaign.title
    end
  end

end
