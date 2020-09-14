require 'rails_helper'

feature "as an authenticated user I want to see a list links to my leagues
        on my home page " do
  let!(:user1) {FactoryBot.create(:user)}
  let!(:user2) {FactoryBot.create(:user)}
  let!(:league1) {FactoryBot.create(:league)}
  let!(:league2) {FactoryBot.create(:league)}
  let!(:league3) {FactoryBot.create(:league)}
  let!(:mem1) {Membership.create!(user:user1,league:league1)}
  let!(:mem2) {Membership.create!(user:user1,league:league2)}
  let!(:mem3) {Membership.create!(user:user2,league:league3)}
  let!(:week1) {Week.create!(week_number:21, year:2018, start_date:Date.new(2017,12,27), end_date:Date.new(2099,4,1))}

  scenario "" do
    visit "/"
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Log in"

    expect(page).to have_content "Signed in successfully"
    expect(page).to have_content "Welcome #{user1.first_name}"
    expect(page).to have_content league1.league_name
    expect(page).to have_content league2.league_name
    expect(page).to have_no_content league3.league_name
  end
end
