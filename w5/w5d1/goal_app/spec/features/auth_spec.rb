require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit new_user_path
  end

  scenario "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      sign_up('user')
      expect(page).to have_content 'user'
      expect(current_path).to eq(goals_path)
    end
  end
end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    User.create!(username: 'user', password: 'password')
    sign_in('user')

    expect(page).to have_content 'user'
    expect(current_path).to eq(goals_path)
  end
end

feature "logging out" do

  scenario "begins with a logged out state" do
    User.create!(username: 'sueruseruwre', password: 'password')
    sign_in('sueruseruwre')
    click_button 'Sign Out'
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
    expect(current_path).to eq(new_session_path)
  end

  scenario "doesn't show username on the homepage after logout" do
    User.create!(username: 'thisis', password: 'password')
    sign_in('thisis')
    click_button 'Sign Out'
    expect(page).not_to have_content 'thisis'
    expect(current_path).to eq(new_session_path)
  end
end
