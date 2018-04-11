require "capybara/rspec"
require "./app/app"


feature "View a list of bookmarks" do
  scenario "A user sees a list of their bookmarks" do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://facebook.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://twitter.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://instagram.com');")

    visit "/"

    click_button 'Bookmarks'

    expect(page).to have_content "http://facebook.com"
    expect(page).to have_content "http://twitter.com"
    expect(page).to have_content "http://instagram.com"
  end
end
