require 'rails_helper'

feature 'user registers', %Q{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # * I must specify a valid email address,
  #   password, and password confirmation
  # * If I don't specify the required information, I am presented with
  #   an error message

  let!(:week) {Week.create!(week_number:21, year:2018, start_date:Date.new(2017,12,27), end_date:Date.new(2099,4,1), main_slate_start:Date.tomorrow)}

  scenario 'provide valid registration information' do
    visit new_user_registration_path

    fill_in 'Username', with: "username"
    fill_in 'First name', with: "firstName"
    fill_in 'Last name', with: "lastName"
    fill_in 'Email', with: "email@eamil.com"
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit new_user_registration_path

    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end
end
