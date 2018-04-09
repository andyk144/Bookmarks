require "capybara/rspec"
require "./app/app"

describe Bookmark do

  feature "Show homepage" do
    scenario "user goes to / path to view homepage" do
      visit "/"
      expect(page).to have_content "Bookmark Manager"
      expect(page).to have_content "http://makersacademy.com"
      expect(page).to have_content "http://destroyallsoftware.com"
      expect(page).to have_content "http://google.com"
    end
  end
end
