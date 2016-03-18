require 'rails_helper'

RSpec.describe Campaign, type: :model do
  # any time you have a group of tests place them in a describe

  describe "validations" do
    # every test scenario must be put with in an 'it' or 'specify' block.
    # it is a method that takes a test example description and a block of code
    # where you can construct your test.
    it "doesn't allow creating a campaign with no name" do
      # GIVEN: campaign with no title
      c = Campaign.new
      # WHEN : we validate the campaign
      campain_valid = c.valid?
      # THEN: expect that campain_valid should be 'false'
      expect(campain_valid).to eq(false)
    end

    it "requres a goal" do
      # GIVEN
      c = Campaign.new
      # WHEN
      c.valid?
      # THEN:
      expect(c.errors).to have_key(:goal)
      # we call methods like: have_key matchers
      # RSpec and RSpec Rails come with many built-in matchers
    end

    it "requires a goal that is more than 10" do
      # GIVEN
      c = Campaign.new(goal: 6)
      # WHEN
      c.valid?
      # THEN
      expect(c.errors).to have_key(:goal)
    end

    it "requires a unique name" do
      # GIVEN
      Campaign.create({name: "abc", goal: 100, description:"abcde"})
      c = Campaign.new(name: "abc")
      # WHEN
      c.valid?
      # THEN
      expect(c.errors).to have_key(:name)
    end
  end
end
