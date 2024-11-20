# spec/features/login_spec.rb

require 'rails_helper'

RSpec.feature "User Login", type: :feature do
  before do
    @user = User.create(email: 'user1@gmail.com', password: 'wrongpass')
  end

  scenario "User logs in successfully" do
    visit login_path

    fill_in 'email', with: 'user1@gmail.com'
    fill_in 'Password', with: 'wrongpass'
    click_button 'Log in'

    expect(page).to have_content('Login successful')
  end

  scenario "User fails to log in with incorrect password" do
    visit login_path

    fill_in 'email', with: 'user1'
    fill_in 'Password', with: '123'
    click_button 'Log in'

    expect(page).to have_content('Login failed')
  end

  scenario "User fails to log in with non-existent username" do
    visit login_path

    fill_in 'Username', with: 'nonexistent'
    fill_in 'Password', with: 'pass123'
    click_button 'Log in'

    expect(page).to have_content('Login failed')
  end
end
