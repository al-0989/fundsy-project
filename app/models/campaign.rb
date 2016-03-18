class Campaign < ActiveRecord::Base

  # This integrates FriendlyId within our model. We're using the 'name' to generate the slug
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  validates :name, presence: true, uniqueness: true
  validates :goal, presence: true,
               numericality: {greater_than_or_equal_to: 10}

  belongs_to :user
  has_many :pledges, dependent: :destroy

  has_many :rewards, dependent: :destroy

  geocoded_by :address   # can also be an IP address. Would use an IP address beacause we dont need to ask the users permission. The IP address is sent automatically with each request
  
  after_validation :geocode          # auto-fetch coordinates

  include AASM

  # setting the whiny_transitions: false option makes it so that it won't throw an exception when an invalid transition happen
  aasm whiney_transtions: false do
    state :draft, initial: true
    state :published
    state :unfunded
    state :funded
    state :canceled

    event :publish do
      transitions from: :draft, to: :published
    end

    event :cancel do
      transitions from: [:draft, :published, :funded], to: :canceled
    end

    event :fund do
      transitions from: :published, to: :funded
    end

    event :unfund do
      transitions from: :published, to: :unfunded
    end
  end

  def published
    where(aasm_state: :published)
  end
  # this enables us to create associated rewards models at the same time we're
  # creating the campaign model.
  # reject_if: :all_blank means that if the user leaves all the fields for the
  #                       reward empty, it will be ignored and not passed to the
  #                       validation
  # allow_destroy: true   means that if you pass in a special attributes _destroy
  #                       with value `true` as part of the `reward` params it
  #                       will delete the reward record all together.
  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true # this means that if they have left the fields blank it will just ignore it. This means that if they only have two rewards you don't have errors


  # This is CarrierWave config:
  # :image is the field in the database that will store the image name
  # ImageUploader is the uploader class we created in /app/uploaders/image_uploader.rb
  mount_uploader :image, ImageUploader

  # def to_param
  #   # for `to_param` to work there must be and id with non-numerical character
  #   # right after. It's good to call a method like `parameterize` which makes it
  #   # url friendly. For instance, `parameterize` replaces spaces with `-`s
  #   "#{id}-#{name}".parameterize
  # end

end
