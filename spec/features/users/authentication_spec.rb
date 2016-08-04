require 'sprc_helper'

feature 'Autentif', js: true do
  feature 'login' do
    scenario 'valid inputs' do
      @user=FactoryGirl.create(:user)
      visit '/sign_in'
      fill_in "Email", with: @user.email
      fill_in "Password", woth: @user.password
      find("button", text: "Sign in").click
      expect(page).to have_content('Sign out')
    end
  end
end

