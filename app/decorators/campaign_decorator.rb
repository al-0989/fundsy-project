class CampaignDecorator < Draper::Decorator
  delegate_all
  # if you call any method on this class it will delegate that call to the object unless you redefine as we will do below.

  def name
    object.name.titleize
  end

  def goal
    h.number_to_currency object.goal
  end

  def end_date
    h.formatted_date_time object.end_date
  end

  def state_label
    # <div class="label label-default"><%= @campaign.aasm_state %></div>
    # in Ruby 2.2.something and up you can actually go "draft": "label-default" and it will understand. We do it the oldschool way with the hash rocket just incase someone is using an older version of Ruby
    bootstrap_classes = {"draft" => "label-default",
                         "published" => "label-info",
                         "unfunded" => "label-danger",
                         "funded" => "label-success",
                         "canceled" => "label-warning"}
    # content_tag will generate html tags for you. You pass it key value pairs as arguments.
    h.content_tag :div, class: "label #{bootstrap_classes[object.aasm_state]}" do
      object.aasm_state
    end
  end

  def publish_button
    if object.draft?
      h.link_to "Publish", h.campaign_publishings_path(object),
                           method: :post,
                           class: "btn btn-primary",
                           data: {confirm: "Are you sure? You won't be able to edit the campaign after it's been published"}
    end
  end


  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
