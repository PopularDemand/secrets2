require 'rails_helper'

describe "Visitor actions" do

  let ( :user ) { build(:user) }

  context "viewing secrets" do

    it "can view all secrets" do
      visit root_path
      expect(page).to have_content "Listing secrets"
    end

    it "cannot see other user's show pages" do
      user.save!
      visit users_path
      click_on "Show"
      expect(page).to have_current_path(new_session_path)
    end

  end

  context "signing up" do
    before do
      visit new_user_path
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password
    end

    it "successfully adds a user for valid signups" do
      # click_on "Create User"
      # expect(page).to have_current_path(user_path(user))
      # expect(page).to have_content("User was successfully created.")
      expect{ click_button "Create User" }.to change(User, :count).by(1)
    end

    it "does not add a user for invalid signups" do
      user_count = User.count
      fill_in "Email", with: ""
      click_on "Create User"
      expect(User.count).to eq(user_count)
    end

  end

end

describe "Authentication" do

  let ( :user ) { create(:user) }

  context "with proper credentials" do

    before do
      sign_in(user)
    end

    it "allows you to sign in" do
      expect(page).to have_content("Welcome, #{user.name}")
    end

  end

  context "with improper credentials" do

    it "does not allow you to sign in" do
      user.password = "NOTFOOBAR"
      sign_in(user)
      expect(page).to have_current_path(session_path)
    end

  end

end

describe "Signed-in user actions (user)" do

  let ( :user ) { create(:user) }

  before do
    sign_in(user)
  end

  context "working with users" do

    it "can edit themselves" do
      visit edit_user_path(user)
      expect(page).to have_content("Editing user")
    end

    it "cannot edit other users" do
      new_user = create(:user)
      visit edit_user_path(new_user)
      expect(page).to have_content("Listing secrets")
    end

    it "can delete themselves" do
      visit users_path
      within("tr", text: user.email) do
        expect{ click_on "Destroy" }.to change(User, :count).by(-1)
      end
    end

    it "cannot delete other users" do
      new_user = create(:user)
      visit users_path
      within("tr", text: new_user.email) do
        expect{ click_on "Destroy" }.to change(User, :count).by(0)
      end
    end

  end

end
