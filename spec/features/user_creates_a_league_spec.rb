require 'rails_helper'

feature "as an authenticated user I be able to create a league " do
  before(:all) do
  Rails.application.load_seed
  end

  let!(:user1) {FactoryBot.create(:user)}
  let!(:user2) {FactoryBot.create(:user)}
  let!(:league1) {FactoryBot.create(:league)}
  let!(:league2) {FactoryBot.create(:league)}
  let!(:league3) {FactoryBot.create(:league)}
  let!(:mem1) {Membership.create!(user:user1,league:league1)}
  let!(:mem2) {Membership.create!(user:user1,league:league2)}
  let!(:mem3) {Membership.create!(user:user2,league:league3)}
  let!(:week1) {Week.create!(week_number:3, year:2018, start_date: Date.today, end_date:Date.tomorrow, main_slate_start:Date.tomorrow)}
  let!(:week2) {Week.create!(week_number:4, year:2018, start_date:(Date.current+4), end_date:(Date.current+5), main_slate_start:Date.tomorrow)}
  let!(:game1) {Game.create!(week_id:Week.current_week.id,
    home_team_id:1,
    away_team_id:6,
    gametime: DateTime.new(Date.tomorrow.year,Date.tomorrow.month, Date.tomorrow.day,Time.now.hour,Time.now.min, Time.now.sec))}
  let!(:game2) {Game.create!(week_id:Week.current_week.id,
    home_team_id:5,
    away_team_id:8,
    gametime: DateTime.new(Date.tomorrow.year,Date.tomorrow.month, Date.tomorrow.day,Time.now.hour,Time.now.min, Time.now.sec ))}
  let!(:game2) {Game.create!(week_id:Week.current_week.id,
    home_team_id:3,
    away_team_id:7,
    gametime: DateTime.new(Date.tomorrow.year,Date.tomorrow.month, Date.tomorrow.day,Time.now.hour,Time.now.min, Time.now.sec ))}

  scenario "User creates a public league" do
    visit "/"
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Log in"

    click_link "Click here to create a custom league!"
    fill_in "League name", with: "This is a custom league"
    fill_in "Max members", with: 10
    choose "public-league-button"
    click_button "Create League"

    expect(page).to have_content "League Homepage for This is a custom league"
    expect(page).to have_content user1.username
    expect(page).to have_no_content user2.username
  end
  scenario "User creates a private league" do
    visit "/"
    click_link "Sign In"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Log in"

    click_link "Click here to create a custom league!"
    fill_in "League name", with: "This is a custom league"
    fill_in "Max members", with: 10
    choose "private-league-button"
    click_button "Create League"

    expect(page).to have_content "League Homepage for This is a custom league"
    expect(page).to have_content user1.username
    expect(page).to have_no_content user2.username
  end
end
