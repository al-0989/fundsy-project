require 'rails_helper'

RSpec.feature "Sessions", type: :feature do

  let!(:user) { FactoryGirl.create(:user) }
  context "with valid credentials" do
    it "redirects to the home page / show the user full name / displays text 'Logged In'" do
      visit new_session_path
      # valid_credentials = FactoryGirl.attributes_for(:user)
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign In"
      expect(current_path).to eq(root_path)
      expect(page).to have_text /#{user.full_name}/i
      expect(page).to have_text /Logged In/i
    end
  end

  context "with invalid credentials" do
    it "doesn't show the user full name and it displays 'Wrong credentials'" do
      visit new_session_path
      fill_in "Email", with: "bad+#{user.email}"
      fill_in "Password", with: "bad+#{user.password}"
      click_button "Sign In"

      expect(current_path).to eq(sessions_path)
      expect(page).to have_text /Wrong Credentials/i
      expect(page).not_to have_text /#{user.full_name}/i
    end
  end
end
