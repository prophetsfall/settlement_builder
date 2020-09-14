require 'rails_helper'

feature "Visitor sees the home page" do
  scenario "non-signed in user sees generic home page" do
    visit '/'
    expect(page).to have_content("Each week")
    expect(page).to have_content("Click here to Sign Up")
  end

end
