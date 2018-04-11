require "capybara/rspec"
require "./app/app"


feature "add a new bookmark" do
  scenario "A user can enter a URL and add a new bookmark" do
    visit "/"
    click_button 'Add New Bookmark'
    fill_in('url', with: 'http://test.com')
    click_button 'Add'
    expect(page).to have_content "You've added http://test.com to your bookmark list"
  end
end
