require "capybara/rspec"
require "./app/app"


feature "add a new bookmark" do
  scenario "A user can enter a URL and add a new bookmark" do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (url) VALUES('http://facebook.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://twitter.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://instagram.com');")

    visit "/"
    click_button 'Add New Bookmark'
    fill_in('url', with: 'http://test.com')
    click_button 'Add'
    click_button 'Bookmarks'

    expect(page).to have_content "http://facebook.com"
    expect(page).to have_content "http://twitter.com"
    expect(page).to have_content "http://instagram.com"
    expect(page).to have_content "http://test.com"

  end
end
