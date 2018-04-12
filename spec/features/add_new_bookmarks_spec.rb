require "capybara/rspec"
require "./app/app"


feature "add a new bookmark" do
  scenario "A user can enter a URL and add a new bookmark" do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://facebook.com', 'Facebook');")
    connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://twitter.com', 'Twitter');")
    connection.exec("INSERT INTO bookmarks (url, name) VALUES('http://instagram.com', 'Instagram');")

    visit "/"
    click_button 'Add New Bookmark'
    fill_in('url', with: 'http://test.com')
    fill_in('bookmark_name', with: 'Test')
    click_button 'Add'
    click_button 'Bookmarks'

    expect(page).to have_content "http://facebook.com"
    expect(page).to have_content "http://twitter.com"
    expect(page).to have_content "http://instagram.com"
    expect(page).to have_content "http://test.com"
  end

  scenario "A user enters an invalid URL and see's an error message" do
    visit "/"
    click_button 'Add New Bookmark'
    fill_in('url', with: 'http://orange')
    fill_in('name', with: 'Orange')
    click_button 'Add'
    expect(page).to have_content "Invalid url input - please try again"
  end
end
