class MyCampaignsController < ApplicationController

  before_action :authenticate_user

  def index
    # this returns all the campaigns associated wiht the current user
    @campaigns = current_user.campaigns
  end
end
