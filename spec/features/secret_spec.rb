require 'rails_helper'

describe "Signed-in user actions (secret)" do

  let ( :user ) { create(:user) }

  before do
    sign_in(user)
  end

  context "working with secrets" do

    let(:secret) { create(:secret, author: user) } # create wasn't working?

    before do
      # secret.save!
      secret
      visit secrets_path
    end

    it "can create a secret" do
      click_on "New Secret"
      expect(page).to have_content("New secret")
    end

    it "can edit their own secrets" do
      within("tr", text: user.name) do
        click_on "Edit"
      end
      expect(page).to have_content("Editing secret")
    end

    it "cannot edit other user's secrets" do
      new_user = create(:user)
      new_secret = create(:secret, author: new_user)
      expect{ visit edit_secret_path(new_secret) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "can delete their own secrets" do
      within("tr", text: user.name) do
        expect{ click_on "Destroy" }.to change(Secret, :count).by(-1)
      end
    end

    it "cannot delete other user's secrets" do
      new_user = create(:user)
      new_secret = create(:secret, author: new_user)
      visit secrets_path
      within("tr", text: new_user.name) do
        # expect{ click_on "Destroy" }.to change(Secret, :count).by(0)
        expect(page).to_not have_content("Destroy")
      end
    end

  end

end
